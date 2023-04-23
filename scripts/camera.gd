extends Camera2D


func _ready():
	var tile_map: TileMap = get_parent().get_parent().get_children().front()
	var map_rect: Rect2i = tile_map.get_used_rect()
	var tile_size: int = tile_map.cell_quadrant_size
	var map_size_in_px: Vector2i = map_rect.size * tile_size
	limit_right = map_size_in_px.x
	limit_bottom = map_size_in_px.y

