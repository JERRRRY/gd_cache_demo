extends Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var score: Node = $score

func _on_body_entered(body: Node2D) -> void:
	score.add_point()
	print("coin +1")
	animation_player.play("pickup")
	
