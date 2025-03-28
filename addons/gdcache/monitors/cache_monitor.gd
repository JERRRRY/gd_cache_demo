extends Node
class_name CacheMonitor

var print_string: String = \
"
Cache: {cname}
Policy: {cpolicy}
Total Keys: {ckeys}/{ccapacity}
Set Keys: {sk}
Get Keys: {rk}
Hit Keys: {hk} ({hkr}% ratio)
Missed Keys: {mk} ({mkr}% ratio)
Evicted Keys: {ek} ({ekr}% ratio)
"

var requested_keys: int = 0

# Found Items (non-null)
var set_keys: int = 0
var hit_keys: int = 0
var evicted_keys: int = 0

var cache: AbstractCache
@export_node_path("AbstractCache") var cache_node: NodePath

func _init(cache: AbstractCache = null) -> void:
	if cache != null:
		self.cache = cache
		self.cache.get_key.connect(_on_get_key)
		self.cache.evict_key.connect(_on_evict_key)
		self.cache.set_key.connect(_on_set_key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.cache_node != null:
		self.cache = get_node(self.cache_node)
		self.cache.get_key.connect(_on_get_key)
		self.cache.evict_key.connect(_on_evict_key)
		self.cache.set_key.connect(_on_set_key)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_set_key(key, value) -> void:
	set_keys += 1

func _on_get_key(key, hit: bool) -> void:
	requested_keys += 1
	hit_keys += int(hit)
	
func _on_evict_key(key) -> void:
	evicted_keys += 1

func get_hit_ratio() -> float:
	return float(hit_keys) / requested_keys

func get_miss_ratio() -> float:
	return 1.0 - (float(hit_keys) / requested_keys)

func get_Eviction_ratio() -> float:
	return float(evicted_keys) / requested_keys

func _to_string() -> String:
	return print_string.format({
		cname = cache.name, 
		cpolicy = cache.policy,
		ckeys = cache.size(),
		ccapacity = cache.CAPACITY,
		sk = set_keys,
		rk = requested_keys,
		hk = hit_keys, 
		hkr = "%.2f" % [get_hit_ratio() * 100],
		mk = requested_keys - hit_keys, 
		mkr = "%.2f" % [get_miss_ratio() * 100],
		ek = evicted_keys, 
		ekr = "%.2f" % [get_Eviction_ratio() * 100]
	})
