extends Area2D


@onready var _from_map_name: String = get_meta("from_map_name")
@onready var _to_map_name: String = get_meta("to_map_name")

var _player: CharacterBody2D


func _on_body_entered(body):
	if body is CharacterBody2D:
		_player = body
		_stop_player()
		_store_params()
		_switch_map()


func _stop_player():
	_player.set_physics_process(false)
	_player.stop_animation()


func _store_params():
	TempStorage.store_params({
		"direction": _player.direction,
		"spawn_point": _from_map_name
	})


func _switch_map():
	SceneChanger.with_fade_to_map(_to_map_name)

