extends Node2D


func _ready():
	var first_map = create_instance_of("honeywood_forest_path")
	_add_map_as_first(first_map)


func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		$pause_screen.show()


func create_instance_of(map_name: String) -> Variant:
	var path: String = "res://scenes/world/" + map_name + ".tscn"
	var packed_scene := ResourceLoader.load(path) as PackedScene
	return packed_scene.instantiate()


func change_map(new_map):
	var current_map = get_children().pop_front()
	current_map.queue_free()
	_add_map_as_first(new_map)


func _add_map_as_first(new_map):
	add_child(new_map)
	move_child(new_map, 0)

