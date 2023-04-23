extends TileMap


func get_underground_for(character_position: Vector2) -> String:
	var map_position: Vector2i = floor(character_position / Constant.HALF_TILE_SIZE)
	var tile_cell: TileData = get_cell_tile_data(0, map_position)
	var underground: String = tile_cell.get_custom_data("sound")
	if underground == "":
		underground = get_meta("step_sound")
	return underground

