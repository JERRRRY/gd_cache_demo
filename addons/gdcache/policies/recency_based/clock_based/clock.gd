extends AbstractCache
class_name CLOCKCache

var hand: int = 0

func __setup() -> void:
	policy = "Clock"

func __get(key: Variant, default: Variant = null, options: Dictionary = {}) -> Variant:
	if has(key):
		hand = keys().find(key)
		#print("get pointer:" + str(hand))
		var kv: Dictionary = super.__get(key, { val = null, r_bit = true })
		kv.r_bit = true
		return kv.val
	else:
		return default

func __set(key: Variant, val: Variant, options: Dictionary = {}) -> void:
	if has(key):
		hand = keys().find(key)
		#print("update pointer:" + str(hand))
		_cache[key] = { val = val, r_bit = true }
	elif size() >= CAPACITY:
		print("ex pointer:" + str(hand))
		if hand+1 == size(): ## get the next hand
			hand = 0  
		else:
			hand += 1
		
		var keys = keys()
		while (_cache[keys[hand]].r_bit):
			_cache[keys[hand]].r_bit = false
			
			if hand+1 == size():
				hand = 0
			else:
				hand += 1
		super.Evict(keys[hand])
		#print("cur pointer:" + str(hand))
		_cache[key] = { val = val, r_bit = true }
		#print("insert pos:" + str(keys().find(key)))
	else:
		_cache[key] = { val = val, r_bit = true }
		hand = keys().find(key)
		#print("new pointer:" + str(hand))
		
