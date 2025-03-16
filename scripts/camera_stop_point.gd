extends Area2D

@onready var clock_cache: CLOCKCache = $"../CLOCKCache"
func _on_body_entered(body: Node2D) -> void:
	var pre_screen_status = clock_cache.Get("screen")
	if pre_screen_status == 0: #the camera is stop previously
		print(pre_screen_status)
		return
	elif pre_screen_status == 1 || pre_screen_status == null:
		print("set camera stop")
		clock_cache.Set("screen", 0)

	
		
	if body.name == "player":
		var camera = body.get_node("camera_follow_player") 
		var scene_root = get_tree().current_scene
		camera.reparent(scene_root)
		
