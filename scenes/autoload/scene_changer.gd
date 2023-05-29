extends Node


func with_fade_to_scene(path: String):
	var action: Callable = func():
		get_tree().change_scene_to_file(path)
	_fade_and_switch(action)


func with_fade_to_world_to_map(map_name: String):
	var action: Callable = func():
		var map_instance = _create_instance_of(map_name)
		TempStorage.store_params({ "new_map": map_instance })
		get_tree().change_scene_to_file("res://scenes/world/world.tscn")
	_fade_and_switch(action)


func with_fade_to_map(map_name: String):
	var map_instance = _create_instance_of(map_name)
	var new_tracks: Array = map_instance.get_node("TileMap").get_meta("audio")
	AudioManager.fade_all_but(new_tracks)

	var action: Callable = func():
		var world = get_tree().root.get_node("world")
		world.change_map_to(map_instance)
	_fade_and_switch(action)


func _fade_and_switch(switch_action: Callable):
	TransitionScreen.fade_to_black()
	await get_tree().create_timer(Constant.FADE_TIME).timeout
	switch_action.call()
	TransitionScreen.fade_to_normal()


func _create_instance_of(map_name: String) -> Variant:
	var path: String = "res://scenes/world/" + map_name + ".tscn"
	var packed_scene := ResourceLoader.load(path) as PackedScene
	return packed_scene.instantiate()

