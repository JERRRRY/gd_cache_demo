extends Area2D
@onready var clock_cache: CLOCKCache = $"../CLOCKCache"

func _on_body_entered(body: Node2D) -> void:
	var pre_screen_status = clock_cache.Get("screen")
	if pre_screen_status == 1 || pre_screen_status == null: #the camera is following previously
		print(pre_screen_status)
		return
	elif pre_screen_status == 0:
		print("set camera move")
		clock_cache.Set("screen",1)
		
	if body.name == "player":
		var scene_root = get_tree().current_scene
		var camera = scene_root.get_node("camera_follow_player")
		camera.reparent(body)
		
