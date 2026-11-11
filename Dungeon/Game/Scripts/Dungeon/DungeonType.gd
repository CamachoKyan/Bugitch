class_name DungeonType extends Node
const ROOM_HIT_BOX_BATTLE = preload("uid://b7oplfr3od4ih")

var Types=["Dungeon","Store","Chest"]

var Size:Vector2i
var Position:Vector2i
var Type
var CenterPosition = (Position + Vector2i.ONE) * 71 -Vector2i(40,40)

var ConectionDir:Array
var Conections:Array #= [Vector2i.UP,Vector2i.RIGHT,Vector2i.DOWN,Vector2i.LEFT]

var ConectedRooms:Array
#spawnear en 15 15 + distancia entre centro sala 45
func _ready() -> void:
	pass
	#Size = randi_range(5,12)
	#
	#for n in 3:
		#if Conections[n] + Position < Vector2.ZERO:
			#print("A")


func CreateRoom():
	Size = Vector2i(randi_range(7,21),randi_range(7,21))
	#71
