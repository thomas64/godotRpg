extends Node2D


func _ready():
	var map_instance = TempStorage.get_param("new_map")
	TempStorage.clear_params()
	_add_map_as_first(map_instance)


func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		$pause_screen.show()


func change_map_to(new_map):
	var current_map = get_children().pop_front()
	current_map.queue_free()
	_add_map_as_first(new_map)


func _add_map_as_first(new_map):
	add_child(new_map)
	move_child(new_map, 0)

