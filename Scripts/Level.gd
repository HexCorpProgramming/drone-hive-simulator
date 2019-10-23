extends Spatial

#For calculating wall the translation:scale ratio, translation always = scale + 0.3

const OFFSET = Vector3(0,0,0)
var tileArray = []
var rowWidths = []

func _ready():
	
	randomize()
	var mapHeight = randi()%5+10 #Height goes from top to bottom.
	var mapWidth = randi()%5+10	 #Width goes from left to right.

	print("Map height is: ", str(mapHeight))
	print("Map width is: ", str(mapWidth))
	
	generate_empty_array(tileArray, mapHeight)
	print("Tile array generated (empty).")
	generate_tiles(tileArray, mapHeight, mapWidth)
	print("Tile array populated.")
	instance_tile_array(tileArray, mapHeight, mapWidth)
	print("Tile array instantiated.")
	instance_walls(mapHeight, mapWidth)
	print("Tile walls instantiated.")

	
func generate_empty_array(tileArray, mapHeight):
	for y in range(mapHeight):
		tileArray.append([])

func generate_tiles(tileArray, mapHeight, mapWidth):
	
	#Purpose: Populates the tileArray with instanced tile objects given a specific map height and width.
	
	for y in range(mapHeight):
		var rowToAdd = []
		for x in range(mapWidth):
			var tile = load("res://Objects/Tiles/BasicTile.tscn").instance()
			rowToAdd.append(tile)
		tileArray[y] = rowToAdd
		rowWidths.append(rowToAdd.size())

func cull_tiles():
	#Generate new height and width to delete from.
	#Update rowWidths with new row widths.
	pass

func instance_tile_array(tileArray, mapHeight, mapWidth):
	
	#Use: 
	
	for y in range(mapHeight):
		for x in range(mapWidth):
			var tile = tileArray[y][x]
			tile.set_name("tile " + str(y) + "," + (str(x)))
			add_child(tile)
			var currentTile = get_node("tile " + str(y) + "," + (str(x)))
			var currentTileFloor = get_node("tile " + str(y) + "," + (str(x))+"/Floor")
			currentTile.translation.x = OFFSET.x + (currentTile.scale.x*currentTileFloor.scale.x*2*x)
			currentTile.translation.z = OFFSET.z + (currentTile.scale.z*currentTileFloor.scale.z*2*y)
			#The above formula sets the tile spacing based on what the scale of the tile object currently is (determined by the Spatial parent).
			#currentTile.scale.x/z = 1 (at time of writing). The X/Y/Z values can be altered without issue to create larger tiles.
			#currentTileFloor.scale.x/z = 2 (This should always be 2. Scale should be set using the Spatial parent).
			#Multiplication by 2 is needed because scale is essentially the radius, and it needs to be multiplied by 2 to get the "diameter".
			#x/y = The current iteration of the for loop. This is what allows the tiles to be tiled.
			pass

func assign_object_positions():
	pass

func instance_walls(mapHeight, mapWidth):
	
	#Use: Find the tiles that are on the map edges and add a wall object as a child node of the tile node.
	
	for y in range(mapHeight):
		add_wall_to_tile(tileArray[y][mapWidth - 1], "EAST")
		add_wall_to_tile(tileArray[y][0], "WEST")
	for x in range(mapWidth):
		add_wall_to_tile(tileArray[mapHeight - 1][x], "SOUTH")
		add_wall_to_tile(tileArray[0][x], "NORTH")

func add_wall_to_tile(tile, direction):
	
	var wall = load("res://Objects/Tiles/BasicWall.tscn").instance()
	
	var eastWestScale = Vector3(0.3,4,2)
	var northSouthScale = Vector3(2,4,0.3)
	
	match direction:
		"EAST":
			print("adding eastern wall.")
			wall.set_name("East")
			wall.translation = Vector3(2.3,4.3,0)
			wall.scale = eastWestScale
			tile.add_child(wall)
		"WEST":
			print("adding western wall.")
			wall.set_name("West")
			wall.translation = Vector3(-2.3,4.3,0)
			wall.scale = eastWestScale
			tile.add_child(wall)
		"NORTH":
			print("adding northern wall.")
			wall.set_name("North")
			wall.translation = Vector3(0,4.3,-2.3)
			wall.scale = northSouthScale
			tile.add_child(wall)
		"SOUTH":
			print("adding southern wall.")
			wall.set_name("South")
			wall.translation = Vector3(0,4.3,2.3)
			wall.scale = northSouthScale
			tile.add_child(wall)
		"NONE":
			print("Error. add_wall_to_tile requires a direction (NORTH, SOUTH, EAST, WEST).")
			return false
		_:
			print("Invalid direction. Check your function calls for typos.")
			return false
	
	
	pass