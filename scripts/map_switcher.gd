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
	var path: String = "res://maps/" + _to_map_name + ".tscn"
	var packed_scene := ResourceLoader.load(path) as PackedScene
	var instanced_scene := packed_scene.instantiate()
	var new_tracks: Array = instanced_scene.get_node("TileMap").get_meta("audio")

	AudioManager.fade_all_but(new_tracks)
	TransitionScreen.fade_to_black()
	await get_tree().create_timer(_FADE_TIME).timeout

	TempStorage.store_params(_params_to_store())
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(instanced_scene)
	get_tree().current_scene = instanced_scene

	TransitionScreen.fade_to_normal()


func _params_to_store() -> Dictionary:
	return {
		"direction": _player.direction,
		"spawn_point": _from_map_name
	}

