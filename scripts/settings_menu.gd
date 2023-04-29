extends Control


var _config = ConfigFile.new()


func on_open():
	_load_settings()
	$back_button.grab_focus()


func _input(event):
	if $resolution/resolutions.is_disabled():
		if $debug_mode.has_focus() \
		and (event.is_action_pressed("ui_up") or event.is_action_pressed("ui_focus_prev")):
			$resolution/resolutions.grab_focus()
		elif $fullscreen_button.has_focus() \
		and (event.is_action_pressed("ui_down") or event.is_action_pressed("ui_focus_next")):
			$resolution/resolutions.grab_focus()


func _on_vsync_button_pressed():
	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		$vsync_button.text = "V-Sync: On"
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		$vsync_button.text = "V-Sync: Off"
	
	_config.set_value("Settings", "vsync", DisplayServer.window_get_vsync_mode())


func _on_fullscreen_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		$fullscreen_button.text = "Fullscreen: On"
		$resolution/resolutions.set_disabled(true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$fullscreen_button.text = "Fullscreen: Off"
		$resolution/resolutions.set_disabled(false)
		_on_resolutions_item_selected($resolution/resolutions.get_selected())
	
	_config.set_value("Settings", "fullscreen", DisplayServer.window_get_mode())


func _on_resolutions_item_focused(_index):
	AudioManager.play_sfx("menu_cursor")


func _on_resolutions_item_selected(index):
	AudioManager.play_sfx("menu_confirm")
	var new_resolution: Vector2i
	if index == 2:
		new_resolution = Vector2i(1920, 1080)
	elif index == 1:
		new_resolution = Vector2i(1600, 900)
	elif index == 0:
		new_resolution = Vector2i(1280, 720)

	DisplayServer.window_set_size(new_resolution)
	get_viewport().size = new_resolution
	
	_config.set_value("Settings", "resolution", new_resolution)


func _on_debug_mode_pressed():
	if $debug_mode.text == "Debug mode: Off":
		$debug_mode.text = "Debug mode: On"
	else:
		$debug_mode.text = "Debug mode: Off"


func _on_back_button_pressed():
	_config.save("res://settings.cfg")
	hide()
	$%main_menu.show()
	$%settings_button.grab_focus()


func _load_settings():
	_config.load("res://settings.cfg")

	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
		$vsync_button.text = "V-Sync: Off"
	else:
		$vsync_button.text = "V-Sync: On"
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		$fullscreen_button.text = "Fullscreen: Off"
		$resolution/resolutions.set_disabled(false)
	else:
		$fullscreen_button.text = "Fullscreen: On"
		$resolution/resolutions.set_disabled(true)

	var resolution = _config.get_value("Settings", "resolution")
	if resolution == Vector2i(1920, 1080):
		$resolution/resolutions.select(2)
	elif resolution == Vector2i(1600, 900):
		$resolution/resolutions.select(1)
	elif resolution == Vector2i(1280, 720):
		$resolution/resolutions.select(0)

