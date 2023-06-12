extends Camera2D


func _init():
	position_smoothing_enabled = false
	limit_smoothed = false


func _ready():
	var map_size: Vector2i = get_parent().get_parent().get_node("TileMap").get_size()
	limit_right = map_size.x
	limit_bottom = map_size.y
	
	await get_tree().create_timer(0.1).timeout
	
	limit_smoothed = true
	position_smoothing_enabled = true

