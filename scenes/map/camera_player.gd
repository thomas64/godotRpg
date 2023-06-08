extends Camera2D


func _init():
	position_smoothing_enabled = false
	limit_smoothed = false


func _ready():
	var tile_map: TileMap = get_parent().get_parent().get_node("TileMap")
	var map_size_in_px: Vector2i = Tools.get_tile_map_size(tile_map)
	limit_right = map_size_in_px.x
	limit_bottom = map_size_in_px.y
	
	await get_tree().create_timer(0.1).timeout
	
	limit_smoothed = true
	position_smoothing_enabled = true

