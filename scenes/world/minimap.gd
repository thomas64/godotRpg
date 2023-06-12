extends Camera2D


func _input(event):
	if is_current():
		if event.is_action_pressed("mini_map") or event.is_action_pressed("ui_cancel"):
			get_viewport().set_input_as_handled()
			_close()


func try_open(map_size: Vector2i):
	if _is_zoom_possible(map_size):
		_open(map_size)
	else:
		AudioManager.play_sfx("menu_error")


func _is_zoom_possible(map_size: Vector2i) -> bool:
	var player_cam_zoom: Vector2 = _get_player_camera().zoom
	return map_size.x * player_cam_zoom.x > Constant.SCREEN_WIDTH \
		and map_size.y * player_cam_zoom.y > Constant.SCREEN_HEIGHT


func _open(map_size: Vector2i):
	get_tree().paused = true
	AudioManager.play_sfx("sfx_minimap")
	var fit_scale: Vector2 = Tools.calculate_scale_to_fit_screen(map_size)
	var fit_zoom: float = minf(fit_scale.x, fit_scale.y)
	zoom = Vector2(fit_zoom, fit_zoom)
	position = map_size / 2.0
	enabled = true
	make_current()
	$fog_of_war.show()
	$fog_of_war.on_show(tile_map)


func _close():
	$fog_of_war.hide()
	AudioManager.play_sfx("sfx_minimap")
	_get_player_camera().make_current()
	enabled = false
	get_tree().paused = false


func _get_player_camera() -> Camera2D:
	var map: Node2D = get_parent().get_children().front()
	return map.get_node("player").get_node("camera_player")

