extends Camera2D


func _init():
	position_smoothing_enabled = false
	limit_smoothed = false


func _ready():
	var tile_map: TileMap = get_parent().get_parent().get_node("TileMap")
	var map_rect: Rect2i = tile_map.get_used_rect()
	var tile_size: int = tile_map.cell_quadrant_size
	var map_size_in_px: Vector2i = map_rect.size * tile_size
	limit_right = map_size_in_px.x
	limit_bottom = map_size_in_px.y
	limit_smoothed = true
	position_smoothing_enabled = true

