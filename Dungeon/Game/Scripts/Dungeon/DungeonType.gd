class_name DungeonType extends Node

var Types=["Dungeon","Store","Chest"]

var Size:int
var Position:Vector2i
var Type

var Conections:Array #= [Vector2i.UP,Vector2i.RIGHT,Vector2i.DOWN,Vector2i.LEFT]

var ConectedRooms:Array
#spawnear en 15 15 + distancia entre centro sala 45
func _ready() -> void:
	Size = randi_range(5,12)
	#
	#for n in 3:
		#if Conections[n] + Position < Vector2.ZERO:
			#print("A")
