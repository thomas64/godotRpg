extends Node


var _params: Dictionary = {}


func change_scene(next_scene: String, params: Dictionary):
	_params = params
	get_tree().change_scene_to_file(next_scene)


func has_param(param_name) -> bool:
	return _params.has(param_name)


func get_param(param_name) -> Variant:
	return _params[param_name]

