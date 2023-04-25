extends Area2D


const _FADE_TIME: float = 0.5

@onready var _from_map_name: String = get_meta("from_map_name")
@onready var _to_map_name: String = get_meta("to_map_name")

var _player: CharacterBody2D


func _on_body_entered(body):
	if body is CharacterBody2D:
		_player = body
		_stop_player()
		_fade_and_switch_scene()


func _stop_player():
	_player.set_physics_process(false)
	_player.stop_animation()


func _fade_and_switch_scene():
	TransitionScreen.fade_to_black()
	await get_tree().create_timer(_FADE_TIME).timeout
	_switch_scene()
	TransitionScreen.fade_to_normal()


func _switch_scene():
	var new_scene: String = "res://maps/" + _to_map_name + ".tscn"
	var params_to_transfer: Dictionary = {
		"direction": _player.direction,
		"spawn_point": _from_map_name
	}
	SceneSwitcher.change_scene(new_scene, params_to_transfer)

