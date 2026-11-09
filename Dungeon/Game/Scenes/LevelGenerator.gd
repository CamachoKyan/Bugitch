extends Node

#
#var Rooms = 5

var DungeonRoom=Object

@export var DungeonTileMap: TileMapLayer
@export var player: CharacterBody2D

var Variant

var Map:Dictionary = {
	
	F1=["[ 1]","[ ]","[ ]","[ ]","[ ]"],
	F2=["[2 ]","[ ]","[ ]","[ ]","[ ]"],
	F3=["[ 3]","[ ]","[ ]","[ ]","[ ]"],
	F4=["[ 4]","[ ]","[ ]","[ ]","[ ]"],
	F5=["[ 5]","[ ]","[ ]","[ ]","[ ]"]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var startte = 0
	
	for n in 5:
		startte= 45*(n+1) -30 
		#startte+= n*15 + 30
		
		print(startte)
	#print(Map.F1)
	#print(Map.keys())
	#print(Map.find_key(0))

	var Conections= [Vector2i.UP,Vector2i.RIGHT,Vector2i.DOWN,Vector2i.LEFT]
	
	var RoomsAmount=6
	
	var Rooms:Array
	var RoomsPosition:Array
	var dir
	var StartRoom = DungeonType.new()
	StartRoom.Position = Vector2i(randi_range(0,4),randi_range(0,4))
	StartRoom.Type="Start"
	StartRoom.Size = 2
	#var LastPosition = StartRoom.Position
	
	#StartRoom.Position=Vector2i(0,4)
	
	print("Posición de Inicio: ",StartRoom.Position)
	
	for n in Conections:
		#if  !(StartRoom.Position + StartRoom.Conections[n] <=Vector2i(4,4) and StartRoom.Position + StartRoom.Conections[n] > Vector2i(-1,-1)):
		if (StartRoom.Position.x + n.x <=4 and StartRoom.Position.x + n.x >=0 and StartRoom.Position.y + n.y <=4 and StartRoom.Position.y + n.y >=0 ):
		#if  (StartRoom.Position.x + Conections[n].x <=4 and StartRoom.Position.x + Conections[n].x >=0 and StartRoom.Position.y + Conections[n].y <=4 and StartRoom.Position.y + Conections[n].y >=0):
			StartRoom.Conections.append(n)
			#print("Donde queda: ",StartRoom.Position + Conections[n])
		#else:
			#print("Se sale")
			#print("Donde queda: ",StartRoom.Position + Conections[n])
			
	
	Rooms.append(StartRoom)
	RoomsPosition.append(StartRoom.Position)
	
	print("Conexiones: ",StartRoom.Conections)
	
	
	#
	#print(StartRoom.Conections.size())
	#print(StartRoom.Conections)
	
	
	#var RoomToGenerate = DungeonType.new()
	
	#print(RoomToGenerate)
	for n in RoomsAmount:
		var LastRoom= Rooms[n]
		var RoomToGenerate = DungeonType.new()
		var RoomPos = Rooms[Rooms.size()-1].Position
		RoomToGenerate.Size = randi_range(5,10)
		print(RoomToGenerate.Size)
		if Rooms[n].Conections.is_empty():
			printerr("Ta vacio")
			#breakpoint
			for i in range(Rooms.size()-2,0,-1):
				if !Rooms[i].Conections.is_empty():
					dir = Rooms[i].Conections.pick_random()
					RoomPos = Rooms[i].Position
					LastRoom= Rooms[i]
					print("Arreglaoo")
					break
		else:
			dir = Rooms[n].Conections.pick_random()
		LastRoom.ConectedRooms.append(RoomToGenerate)
		Rooms[n].Conections.erase(dir)
		RoomToGenerate.Position = RoomPos +dir
		#var NextRoom = Rooms[n]
		RoomToGenerate.Type = RoomToGenerate.Types.pick_random()
		#print()
		#print("Cuarto #",n)
		#print("Cuarto en:",RoomToGenerate.Position)
		for rumi in Conections:
			if (RoomToGenerate.Position.x + rumi.x <=4 and RoomToGenerate.Position.x + rumi.x >=0 and \
			RoomToGenerate.Position.y + rumi.y <= 4 and RoomToGenerate.Position.y + rumi.y >=0 and !(RoomsPosition.has(RoomToGenerate.Position + rumi))):
			#rumi != (dir*-1) ) and\
			#!(RoomsPosition.has(RoomToGenerate.Position + rumi)):
				
				
				#print(rumi)
				#print("RoomToGenerate.Position + rumi <Vector2i(5,5): ",RoomToGenerate.Position + rumi <Vector2i(5,5))
				#print("RoomToGenerate.Position + rumi > Vector2i(-1,-1): ",RoomToGenerate.Position + rumi > Vector2i(-1,-1))
				#print("rumi != (dir*-1): ",rumi != (dir*-1))
				#print("(RoomsPosition.has(RoomToGenerate.Position + rumi)): ",(RoomsPosition.has(RoomToGenerate.Position + rumi)))
				#print("Queda en: ",rumi+RoomToGenerate.Position)
				#print("Añadir: ",rumi)
				RoomToGenerate.Conections.append(rumi)
				
			#print(rumi)
			#print("RoomToGenerate.Position + rumi <Vector2i(5,5): ",RoomToGenerate.Position + rumi <Vector2i(5,5))
			#print("RoomToGenerate.Position + rumi > Vector2i(-1,-1): ",RoomToGenerate.Position + rumi > Vector2i(-1,-1))
			#print(dir)
			#print("rumi != (dir*-1): ",rumi != (dir*-1))
			#print("(RoomsPosition.has(RoomToGenerate.Position + rumi)): ",(RoomsPosition.has(RoomToGenerate.Position + rumi)))
			#print("Queda en: ",rumi+RoomToGenerate.Position)
			#print("")
		
		RoomsPosition.append(RoomToGenerate.Position)
		Rooms.append(RoomToGenerate)
		
		
		
		
	var ExitRoom = DungeonType.new()
	ExitRoom.Type="Exit"
	ExitRoom.Size = 4
	ExitRoom.Position = RoomsPosition[RoomsPosition.size()-1] +Rooms[Rooms.size()-1].Conections.pick_random()
	
	Rooms.append(ExitRoom)
	RoomsPosition.append(ExitRoom)
	
	
	
	for n in Rooms.size():
		#print(Rooms[n].Position)
		var CreateRoomPos = ((Rooms[n].Position + Vector2i(1,1) )) * Vector2i(45,45) -Vector2i(30,30)
		var NextRoomPos = ((Rooms[n].Position + Vector2i(1,1) )) * Vector2i(45,45) -Vector2i(30,30)
		for x in range( (CreateRoomPos.x - (Rooms[n].Size*2))+1,(CreateRoomPos.x + (Rooms[n].Size*2))) :
			#print("Dentro")
			for z in range( CreateRoomPos.y - (Rooms[n].Size*2)+1,CreateRoomPos.y + (Rooms[n].Size*2)):
				if x == (CreateRoomPos.x - (Rooms[n].Size*2))+1:
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(0,2))
					
				elif x == (CreateRoomPos.x + (Rooms[n].Size*2))-1:
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(7,2))
					
				elif z == CreateRoomPos.y - (Rooms[n].Size*2)+1:
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(2,0))
					
				elif z == CreateRoomPos.y + (Rooms[n].Size*2)-1:
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(2,7))
				
					
				else:
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(1,1))
					
				#print("pintao")
		print(Rooms[n].Type)
		DungeonTileMap.set_cell(CreateRoomPos,1,Vector2i(3,2))
		
		#if poner if de preguntar si estan conectados
		if n != Rooms.size()-1:
			for j in range( (CreateRoomPos.x + (Rooms[n].Size*2)), NextRoomPos.x -Rooms[n+1].Size*2):
				for k in range( CreateRoomPos.y +2,NextRoomPos.y -2 ):
						DungeonTileMap.set_cell(Vector2i(j,k),1,Vector2i(3,5))
						print("AYYYYYYYY")
		
		#DungeonTileMap.set_cell() pensar en formula para que al multiplicar la posicion ´+
	
	print(DungeonTileMap.map_to_local(((Rooms[0].Position + Vector2i(1,1) )) * Vector2i(45,45) -Vector2i(30,30)) ) 
	player.position = DungeonTileMap.map_to_local(((Rooms[0].Position + Vector2i(1,1) )) * Vector2i(45,45) -Vector2i(30,30)) 
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
