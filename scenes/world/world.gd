extends Node2D


func _ready():
	var map_instance = TempStorage.get_param("new_map")
	TempStorage.clear_params()
	_setup_new_map(map_instance)


func _input(event):
	if event.is_action_pressed("pause"):
		$pause_screen.show()
	elif event.is_action_pressed("mini_map"):
		$minimap.try_open()


func change_map_to(new_map):
	var current_map = get_children().pop_front()
	current_map.queue_free()
	_setup_new_map(new_map)


func _setup_new_map(new_map):
	_add_map_as_first(new_map)
	_setup_minimap_of(new_map)


func _add_map_as_first(new_map):
	add_child(new_map)
	move_child(new_map, 0)


func _setup_minimap_of(new_map):
	var tile_map: TileMap = new_map.get_node("TileMap")
	var map_size_in_px: Vector2i = Tools.get_tile_map_size(tile_map)
	$minimap.set_new_map_size(map_size_in_px)

