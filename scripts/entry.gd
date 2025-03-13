extends Area2D


func _on_body_entered(body: Node2D) -> void:
	print("enter zone + 1")
	var cache_transfer = global_cache.Get("transfer",  {"default": 0}) + 1
	global_cache.Set("transfer", cache_transfer)
	print("cache save:{transfer,"+str(cache_transfer)+"}")
	print("cache status:")
	print(global_cache._to_string())
	
	get_tree().current_scene.queue_free()
	var new_scene = load("res://scenes/scene_2.tscn").instantiate()
	get_tree().root.add_child(new_scene)
