extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("flag+1")
	var cache_flag = global_cache.Get("flag",  {"default": 0}) + 1
	global_cache.Set("flag", cache_flag)
	print("cache save:{flag,"+str(cache_flag)+"}")
	print("cache status:")
	print(global_cache._to_string())
