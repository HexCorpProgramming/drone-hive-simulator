extends Spatial

export var default_x = 15
export var default_y = 15

#The tiles and walls are scaled cubes by default, which means they can tesselate by knowing their scale.
#If you ever decide to use something other than default cubes, Hex be with you.
export (PackedScene) var  tile_source = load("res://Objects/Tiles/BasicTile.tscn")
export (PackedScene) var  wall_source = load("res://Objects/Tiles/BasicWall.tscn")

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
	delete_tiles(1,1,14,14)
	get_all_tiles()
	
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
	print("TOTAL COUNT OF TILES: ",flattened_list.size())
	return flattened_list
	
func add_tile(x,y):
	if !valid(x,y):
		return
	if get_tile(x,y) != null:
		return
	var new_tile = tile_source.instance()
	new_tile.name = str(x)+","+str(y)
	#Default cubes can tesselate really well by scale alone. Scale is essentially radius, so scale * 2 is diameter.
	new_tile.translation = Vector3(new_tile.scale.x * 2 * x, 0, new_tile.scale.z * 2 * y)
	add_child(new_tile)
	tiles[x][y] = new_tile
	
func add_tiles(from_x, from_y, to_x, to_y):
	if !valid(from_x, from_y):
		print("beep")
		return
	if !valid(to_x, to_y):
		print("boop")
		return
	if (from_x == to_x and from_y == to_y):
		print("add_tiles parameters cannot be identical.")
		return
	for y in range(from_y, to_y):
		print("beep")
		for x in range(from_x, to_x):
			print("boop")
			add_tile(x,y)
	
func delete_tile(x,y):
	if !valid(x,y):
		return
	var tile = get_tile(x,y)
	if tile != null and tile.has_method("queue_free"):
		tile.queue_free()
		tiles[x][y] = null
	
func delete_tiles(from_x, from_y, to_x, to_y):
	if !valid(from_x, from_y):
		print("beep")
		return
	if !valid(to_x, to_y):
		print("boop")
		return
	if (from_x == to_x and from_y == to_y):
		print("add_tiles parameters cannot be identical.")
		return
	for y in range(from_y, to_y):
		print("beep")
		for x in range(from_x, to_x):
			print("boop")
			delete_tile(x,y)
	
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
	print("Added ", rows+1, " row(s).")
	
func valid(x,y):
	return x <= tiles.size() and y <= tiles[x].size()