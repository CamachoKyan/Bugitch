extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var WeaponSprite: Marker2D
@export var player_animations: AnimatedSprite2D
@export var sprite_2d: Sprite2D

func _ready() -> void:
	player_animations.play("idle")
	Global.Player = self

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if 0 > global_position.x - get_global_mouse_position().x:
		player_animations.flip_h = false
		sprite_2d.flip_v = false
	else:
		player_animations.flip_h = true
		sprite_2d.flip_v = true

	
	WeaponSprite.look_at(get_global_mouse_position())
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction:
		velocity= direction * SPEED
		player_animations.play("default")
		
	else:
		player_animations.play("idle")
		
		velocity*=0

	move_and_slide()
