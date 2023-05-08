extends Control


var _config = ConfigFile.new()


func on_open():
	_load_settings()
	$back_button.grab_focus()


func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		accept_event()
		_on_back_button_pressed()
		return

	_handle_error_sound_sliders(event)


func _process(_delta):
	_update_font_colors_when_slider_has_focus()


func _on_bgm_value_changed(value):
	AudioManager.play_sfx("menu_cursor")
	_set_bgm_value(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), linear_to_db(value))
	_config.set_value("Audio", "bgm_volume", value)


func _on_bgs_value_changed(value):
	AudioManager.play_sfx("menu_cursor")
	_set_bgs_value(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgs"), linear_to_db(value))
	_config.set_value("Audio", "bgs_volume", value)


func _on_sfx_value_changed(value):
	AudioManager.play_sfx("menu_cursor")
	_set_sfx_value(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(value))
	_config.set_value("Audio", "sfx_volume", value)


func _on_back_button_pressed():
	AudioManager.play_sfx("menu_back")
	_config.save(Constant.SETTINGS_FILE)
	hide()


func _load_settings():
	_config.load(Constant.SETTINGS_FILE)

	$bgm_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("bgm")))
	$bgs_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("bgs")))
	$sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("sfx")))

	_set_bgm_value($bgm_slider.value)
	_set_bgs_value($bgs_slider.value)
	_set_sfx_value($sfx_slider.value)


func _set_bgm_value(value):
	var percentage = _get_percentage($bgm_slider.value, $bgm_slider.max_value)
	$bgm_value.text = _get_percentage_string(percentage)


func _set_bgs_value(value):
	var percentage = _get_percentage($bgs_slider.value, $bgs_slider.max_value)
	$bgs_value.text = _get_percentage_string(percentage)


func _set_sfx_value(value):
	var percentage = _get_percentage($sfx_slider.value, $sfx_slider.max_value)
	$sfx_value.text = _get_percentage_string(percentage)


func _get_percentage_string(value: float) -> String:
	return "   %d%%" % (value * 100)


func _get_percentage(value: float, max_value: float) -> float:
	return value / max_value


func _handle_error_sound_sliders(event):
	if $bgm_slider.has_focus() or $bgs_slider.has_focus() or $sfx_slider.has_focus():
		if (event.is_action_pressed("ui_left") and (
			($bgm_slider.has_focus() and $bgm_slider.value == 0) or
			($bgs_slider.has_focus() and $bgs_slider.value == 0) or
			($sfx_slider.has_focus() and $sfx_slider.value == 0)
			)
		) \
		or (event.is_action_pressed("ui_right") and (
			($bgm_slider.has_focus() and $bgm_slider.value == 1) or
			($bgs_slider.has_focus() and $bgs_slider.value == 1) or
			($sfx_slider.has_focus() and $sfx_slider.value == 1)
			)
		): AudioManager.play_sfx("menu_error")


func _update_font_colors_when_slider_has_focus():
	var default: Color = get_theme_color("font_color", "Button")
	var focus: Color = get_theme_color("font_focus_color", "Button")

	if $bgm_slider.has_focus():
		$bgm_title.add_theme_color_override("font_color", focus)
	else:
		$bgm_title.add_theme_color_override("font_color", default)

	if $bgs_slider.has_focus():
		$bgs_title.add_theme_color_override("font_color", focus)
	else:
		$bgs_title.add_theme_color_override("font_color", default)

	if $sfx_slider.has_focus():
		$sfx_title.add_theme_color_override("font_color", focus)
	else:
		$sfx_title.add_theme_color_override("font_color", default)

