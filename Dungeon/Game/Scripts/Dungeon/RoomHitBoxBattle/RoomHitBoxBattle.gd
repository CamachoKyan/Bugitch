extends Area2D
@export var HitBox: CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Hitbox: ",HitBox.shape.get_rect())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func RoomHitBox(body: Node2D) -> void:
	pass # Replace with function body.
