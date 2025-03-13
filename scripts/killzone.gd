extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	print("kill+1")
	var cache_kill = global_cache.Get("kill",  {"default": 0}) + 1
	global_cache.Set("kill", cache_kill)
	print("cache save:{kill,"+str(cache_kill)+"}")
	print("cache status:")
	print(global_cache._to_string())
	
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene() 

	
