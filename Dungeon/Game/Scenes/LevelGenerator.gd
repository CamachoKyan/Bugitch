extends Node

var DungeonRoom=Object

@export var DungeonTileMap: TileMapLayer
@export var player: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var Conections= [Vector2i.UP,Vector2i.RIGHT,Vector2i.DOWN,Vector2i.LEFT]
	
	var RoomsAmount=6
	
	var Rooms:Array
	var RoomsPosition:Array
	var dir
	var StartRoom = DungeonType.new()
	StartRoom.Position = Vector2i(randi_range(0,4),randi_range(0,4))
	StartRoom.Position = Vector2.ZERO
	StartRoom.Type="Start"
	StartRoom.Size = Vector2.ONE *21

	
	print("Posición de Inicio: ",StartRoom.Position)
	
	for n in Conections:
		if (StartRoom.Position.x + n.x <=4 and StartRoom.Position.x + n.x >=0 and StartRoom.Position.y + n.y <=4 and StartRoom.Position.y + n.y >=0 ):
			StartRoom.Conections.append(n)
	
	Rooms.append(StartRoom)
	RoomsPosition.append(StartRoom.Position)
	
	print("Conexiones: ",StartRoom.Conections)
	
	for n in RoomsAmount:
		var LastRoom= Rooms[n]
		var RoomToGenerate = DungeonType.new()
		var RoomPos = Rooms[Rooms.size()-1].Position
		RoomToGenerate.Size = Vector2i(randi_range(7,21),randi_range(7,21))
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
		LastRoom.ConectionDir.append(dir)
		Rooms[n].Conections.erase(dir)
		RoomToGenerate.Position = RoomPos +dir

		RoomToGenerate.Type = RoomToGenerate.Types.pick_random()

		for rumi in Conections:
			if (RoomToGenerate.Position.x + rumi.x <=4 and RoomToGenerate.Position.x + rumi.x >=0 and \
			RoomToGenerate.Position.y + rumi.y <= 4 and RoomToGenerate.Position.y + rumi.y >=0 and !(RoomsPosition.has(RoomToGenerate.Position + rumi))):
			
				RoomToGenerate.Conections.append(rumi)
			
		
		RoomsPosition.append(RoomToGenerate.Position)
		Rooms.append(RoomToGenerate)
		
		
		
		
	var ExitRoom = DungeonType.new()
	ExitRoom.Type="Exit"
	ExitRoom.Size = Vector2i.ONE * 4
	ExitRoom.Position = RoomsPosition[RoomsPosition.size()-1] +Rooms[Rooms.size()-1].Conections.pick_random()
	
	Rooms.append(ExitRoom)
	RoomsPosition.append(ExitRoom)
	
	
	
	for n in Rooms.size():
		#print(Rooms[n].Position)
		var CreateRoomPos = ((Rooms[n].Position + Vector2i(1,1) )) * Vector2i(53,53) -Vector2i(22,22)
		var NextRoomPos
		if n != Rooms.size()-1:
			NextRoomPos = ((Rooms[n+1].Position + Vector2i(1,1) )) * Vector2i(53,53) -Vector2i(22,22)
			
		#var minx
		#var maxx
		#var miny
		#var maxy
		##if poner if de preguntar si estan conectados
		#if !Rooms[n].ConectionDir.is_empty() and n != Rooms.size()-1:
			#for roms in Rooms[n].ConectionDir:
			#
				#match roms:
					#Vector2i.UP:
						#minx = CreateRoomPos.x-2
						#maxx = CreateRoomPos.x+2
						#miny = NextRoomPos.y + Rooms[n].Size*2
						#maxy = CreateRoomPos.y - Rooms[n+1].Size*2
					#
					#Vector2i.DOWN:
						#minx = CreateRoomPos.x-2
						#maxx = CreateRoomPos.x+2
						#miny = CreateRoomPos.y - Rooms[n].Size*2
						#maxy = NextRoomPos.y + Rooms[n+1].Size*2
						#
					#Vector2i.RIGHT:
						#minx = CreateRoomPos.y - Rooms[n].Size*2
						#maxx = NextRoomPos.y + Rooms[n].Size*2
						#miny = CreateRoomPos.y-2
						#maxy = CreateRoomPos.y+2
						#
					#Vector2i.LEFT:
						#minx = NextRoomPos.y - Rooms[n].Size*2
						#maxx = CreateRoomPos.y + Rooms[n].Size*2
						#miny = CreateRoomPos.y-2
						#maxy = CreateRoomPos.y+2
			#
			#
			#
		##if n != Rooms.size()-1:
			##for j in range( (CreateRoomPos.x + (Rooms[n].Size*2)), NextRoomPos.x -Rooms[n+1].Size*2):
				##for k in range( CreateRoomPos.y +2,NextRoomPos.y -2 ):
						##DungeonTileMap.set_cell(Vector2i(j,k),1,Vector2i(3,5))
						##print("AYYYYYYYY")
						#
				#if n != Rooms.size()-1:
					#for j in range(minx,maxx):
						#for k in range(miny,maxy):
								#DungeonTileMap.set_cell(Vector2i(j,k),1,Vector2i(3,5))
								##print("AYYYYYYYY")
		#
			
			
		for x in range( (CreateRoomPos.x - (Rooms[n].Size.x)),(CreateRoomPos.x + (Rooms[n].Size.x))+1) :
			#print("Dentro")
			for z in range( CreateRoomPos.y - (Rooms[n].Size.y),CreateRoomPos.y + (Rooms[n].Size.y)+1 ):
				if x == (CreateRoomPos.x - (Rooms[n].Size.x)):
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(0,2))
					
				elif x == (CreateRoomPos.x + (Rooms[n].Size.x)):
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(7,2))
					
				elif z == CreateRoomPos.y - (Rooms[n].Size.y):
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(2,0))
					
				elif z == CreateRoomPos.y + (Rooms[n].Size.y):
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(2,7))
				
					
				else:
					DungeonTileMap.set_cell(Vector2i(x,z),1,Vector2i(1,1))
					
		print(Rooms[n].Type)
		DungeonTileMap.set_cell(CreateRoomPos,1,Vector2i(3,2))
		#42
		if !Rooms[n].ConectionDir.is_empty() and n != Rooms.size()-1:
			for roms in Rooms[n].ConectionDir:
				var minx
				var maxx
				var sizeto
				var anch
				if roms == Vector2i.UP or roms == Vector2i.DOWN:
					sizeto= (42-Rooms[n].Size.y - Rooms[n+1].Size.y)
					anch = 5;
					
						#if n != Rooms.size()-1:
									#for j in range(minx,maxx):
										#for k in range(miny,maxy):
												#DungeonTileMap.set_cell(Vector2i(j,k),1,Vector2i(3,5))
												#print("AYYYYYYYY")
		
		#DungeonTileMap.set_cell() pensar en formula para que al multiplicar la posicion ´+
	
	print(DungeonTileMap.map_to_local(((Rooms[0].Position + Vector2i(1,1) )) * Vector2i(53,53) -Vector2i(22,22)) ) 
	player.position = DungeonTileMap.map_to_local(((Rooms[0].Position + Vector2i(1,1) )) * Vector2i(53,53) -Vector2i(22,22)) 
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
