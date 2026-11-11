extends CharacterBody2D
@export var attack_timer: Timer
@export var hit_box: CollisionShape2D
@export var sprite_2d: Sprite2D

const SPEED = 60
var hitboxflip=false

func _ready() -> void:
	attack_timer.timeout.connect(Attack)

func _physics_process(delta: float) -> void:
	
	if 0> position.x-Global.Player.position.x:
		sprite_2d.flip_h = false
	else:	
		sprite_2d.flip_h = true
	
	
	hit_box.look_at(Global.Player.position)

		
	
	var direction = (Global.Player.position - position).normalized()
	if position.distance_to(Global.Player.position) <=300 and position.distance_to(Global.Player.position) >=30:
	
		velocity= direction * SPEED
	else:
		velocity *= 0

	move_and_slide()

func Attack():
	print("pegale")

func SpiderHitBox(body: Node2D) -> void:
	if body == Global.Player:
		attack_timer.start(1)
	
func SpiderHitBoxExit(body: Node2D) -> void:
	if body == Global.Player:
		attack_timer.paused = true
	
