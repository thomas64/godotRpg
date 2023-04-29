extends Node


var _params: Dictionary = {}


func store_params(params: Dictionary):
	_params = params


func has_param(param_name) -> bool:
	return _params.has(param_name)


func get_param(param_name) -> Variant:
	return _params[param_name]

