extends CharacterBody2D


const SPEED = 180.0
const JUMP_VELOCITY = -320.0
var attacking = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.flip_h = true	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction<0:
		animated_sprite_2d.flip_h = true
	elif direction>0:
		animated_sprite_2d.flip_h = false
	
	if not attacking:
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	
		
	if Input.is_action_just_pressed("attack1") and not attacking:
		attack("attack1")
	
	if Input.is_action_just_pressed("attack2") and not attacking:
		attack("attack2")
	
	if Input.is_action_just_pressed("attack3") and not attacking:
		attack("attack3")	
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func attack(atk: String):
	attacking = true
	animated_sprite_2d.play(atk)
	animated_sprite_2d.animation_looped.connect(_on_animation_finished)

func _on_animation_finished():
		attacking = false	
