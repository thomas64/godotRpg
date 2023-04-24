extends Area2D


var _from_map_name: String
var _to_map_name: String


func _ready():
	_from_map_name = get_meta("from_map_name")
	_to_map_name = get_meta("to_map_name")


func _on_body_entered(body):
	if body is CharacterBody2D:
		_stop_player(body)
		_fade_and_switch_scene(body)


func _stop_player(body):
	body.set_physics_process(false)
	body.stop_animation()


func _fade_and_switch_scene(body):
	var fader = $transition_screen/AnimationPlayer
	fader.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	_switch_scene(body)
	fader.play("fade_to_normal")


func _switch_scene(body):
	SceneSwitcher.change_scene(
		"res://maps/" + _to_map_name + ".tscn",
		{	"direction": body.direction, 
			"spawn_point": _from_map_name }
	)

