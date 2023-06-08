extends Camera2D


var _map_size_in_px: Vector2i


func _input(event):
	if is_current():
		if event.is_action_pressed("mini_map") or event.is_action_pressed("ui_cancel"):
			get_viewport().set_input_as_handled()
			_close()


func set_new_map_size(new_map_size: Vector2i):
	_map_size_in_px = new_map_size


func try_open():
	if _is_zoom_possible():
		_open()
	else:
		AudioManager.play_sfx("menu_error")


func _is_zoom_possible() -> bool:
	var player_cam_zoom: Vector2 = _get_player_camera().zoom
	return _map_size_in_px.x * player_cam_zoom.x > Constant.SCREEN_WIDTH \
		and _map_size_in_px.y * player_cam_zoom.y > Constant.SCREEN_HEIGHT


func _open():
	get_tree().paused = true
	AudioManager.play_sfx("sfx_minimap")
	var fit_scale: Vector2 = Tools.calculate_scale_to_fit_screen(_map_size_in_px)
	var fit_zoom: float = minf(fit_scale.x, fit_scale.y)
	zoom = Vector2(fit_zoom, fit_zoom)
	position = _map_size_in_px / 2.0
	enabled = true
	make_current()


func _close():
	AudioManager.play_sfx("sfx_minimap")
	_get_player_camera().make_current()
	enabled = false
	get_tree().paused = false


func _get_player_camera() -> Camera2D:
	var map: Node2D = get_parent().get_children().front()
	return map.get_node("player").get_node("camera_player")

