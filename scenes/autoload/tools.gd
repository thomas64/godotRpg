extends Node


func get_tile_map_size(tile_map: TileMap) -> Vector2i:
	var map_rect: Rect2i = tile_map.get_used_rect()
	var tile_size: int = tile_map.cell_quadrant_size
	return map_rect.size * tile_size


func calculate_scale_to_fit_screen(object_size: Vector2) -> Vector2:
	var viewport_width: int = get_viewport().size.x
	var viewport_height: int = get_viewport().size.y
	var x_diff: float = Constant.SCREEN_WIDTH / viewport_width
	var y_diff: float = Constant.SCREEN_HEIGHT / viewport_height
	var x_scale: float = viewport_width / object_size.x
	var y_scale: float = viewport_height / object_size.y
	return Vector2(x_scale * x_diff, y_scale * y_diff)


func get_center_screen() -> Vector2:
	var viewport_width: int = get_viewport().size.x
	var viewport_height: int = get_viewport().size.y
	var x_diff: float = Constant.SCREEN_WIDTH / viewport_width
	var y_diff: float = Constant.SCREEN_HEIGHT / viewport_height
	return Vector2(viewport_width / 2.0 * x_diff, viewport_height / 2.0 * y_diff)

