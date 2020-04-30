extends Spatial

export var default_x = 15
export var default_y = 15
export var tile_scale = 4

#The tiles and walls are scaled cubes by default, which means they can tesselate by knowing their scale.
#If you ever decide to use something other than default cubes, Hex be with you.
export (PackedScene) var  tile_source = load("res://Objects/Tiles/BasicTile.tscn")
export (PackedScene) var  wall_source = load("res://Objects/Tiles/BasicWall.tscn")
var spawner_source = load("res://Objects/Constructibles/SubjectSpawner/Spawner.tscn")

enum direction {EAST, NORTH, WEST, SOUTH}

#2D arrays are really annoying in Godot. The only way to use them right now is the ol' "array in an array" trick.
#Arrays in Godot are sized dynamically,
#So there's not actually a limit to how many tiles can be appended to each row.
#This is a good thing, since we won't have to add a new empty element and resize every array every time we add a column of tiles.
var tiles = []

func _ready():
	create_default_tiles()
	
func create_default_tiles():
	#Delete any pre-existing tiles.
	for node in get_children():
		node.queue_free()
	
	#Reset the tile array
	tiles.clear()
	
	#Add the tiles
	add_rows(default_x, default_y)
	add_tiles(0,0,15,15)
	add_walls_to_tiles(true)
	delete_walls_from_tile(1,1)
	add_spawner(0,8)
	
	add_spawner(0,1)
	
	add_spawner(3,0)
	
func get_tile(x,y):
	if !valid(x,y):
		print("Invalid co-ords.")
		return null
	return tiles[x][y]
	
func get_all_tiles():
	var flattened_list = []
	for row in tiles:
		for tile in row:
			if tile != null:
				flattened_list.append(tile)	
	print("Total tilecount: ",flattened_list.size())
	return flattened_list
	
func add_tile(x,y):
	if !valid(x,y):
		return
	if get_tile(x,y) != null:
		return
	var new_tile = tile_source.instance()
	new_tile.name = str(x)+","+str(y)
	#Default cubes can tesselate really well by scale alone. Scale is essentially radius, so scale * 2 is diameter.
	new_tile.translation = Vector3(tile_scale * x, 0, tile_scale * y)
	add_child(new_tile)
	tiles[x][y] = new_tile
	
func add_spawner(x,y):
	
	#Spawners can only be added on the left or the top.
	
	if !(x == 0 and y != 0 or x != 0 and y == 0):
		print("Invalid co ords")
		return
	
	if !valid(x,y):
		return
	var tile = get_tile(x,y)
	delete_walls_from_tile(x,y)
	var new_spawner = spawner_source.instance()
	if y == 0:
		new_spawner.rotation_degrees.y = -90
	tile.add_child(new_spawner)
	
func add_tiles(from_x, from_y, to_x, to_y):
	if !valid(from_x, from_y):
		return
	if !valid(to_x, to_y):
		return
	if (from_x == to_x and from_y == to_y):
		print("add_tiles parameters cannot be identical.")
		return
	for y in range(from_y, to_y):
		for x in range(from_x, to_x):
			add_tile(x,y)
			print("Added tile at X[",str(x),"] Y[",str(y),"]")
	
func delete_tile(x,y):
	if !valid(x,y):
		return
	var tile = get_tile(x,y)
	if tile != null and tile.has_method("queue_free"):
		tile.queue_free()
		tiles[x][y] = null
	
func delete_tiles(from_x, from_y, to_x, to_y):
	if !valid(from_x, from_y):
		return
	if !valid(to_x, to_y):
		return
	if (from_x == to_x and from_y == to_y):
		print("add_tiles parameters cannot be identical.")
		return
	for y in range(from_y, to_y):
		for x in range(from_x, to_x):
			delete_tile(x,y)
	
func add_wall_to_tile(x,y,direction):
	
	#0 / 0: East
	#90 / 1: North
	#180 / 2: West
	#270 / 3: South
	
	var tile = get_tile(x,y)
	if tile == null:
		print("Tried adding wall to null tile.")
		return
	var new_wall = wall_source.instance()
	new_wall.rotation_degrees.y = direction * 90
	tile.add_child(new_wall)
	
func delete_walls_from_tile(x,y):
	if !valid(x,y):
		return
	var tile = get_tile(x,y)
	if tile.get_child_count() == 1:
		print("Tile has no walls.")
		return
	else:
		for wall in range(1,tile.get_child_count()):
			tile.get_child(wall).queue_free()
	
	
func add_walls_to_tiles(lazy=true):
	if lazy:
		print("Adding walls to tiles.")
		for tile_x in range(0,default_x):
			add_wall_to_tile(tile_x,0,1)
			add_wall_to_tile(tile_x,default_y-1,3)
		for tile_y in range(0,default_y):
			add_wall_to_tile(0,tile_y,2)
			add_wall_to_tile(default_x-1,tile_y,0)
	else:
		print("Strict wall-adding not implemented.")
	
	
func add_rows(size, rows = 1):
	#Size and rows will be +1 as a gutter so we don't go out of bounds
	#Validate
	if rows == 0:
		print("Row must be > 0.")
	#Setup row.
	for i in range(0, rows+1):
		var row = []
		for i in range(0, size+1):
			row.append(null)
		tiles.append(row)
	print("Added ", rows, " row(s) to tilemap (+1 as a gutter).")
	
func valid(x,y):
	return x <= tiles.size() and y <= tiles[x].size()