extends Control


var _config = ConfigFile.new()


func _ready():
	$%resolutions.get_popup().window_input.connect(_input)


func on_open():
	_load_settings()
	$%back_button.grab_focus()


func _input(event):
	if visible and $settings_menu.visible:

		if event.is_action_pressed("ui_cancel"):
			accept_event()
			if $%resolutions.get_popup().visible:
				$%resolutions.get_popup().hide()
			else:
				_on_back_button_pressed()
			return

		if $%resolutions.is_disabled():
			if ($%debug_mode.has_focus() and event.is_action_pressed("ui_up")) \
			or ($%fullscreen_button.has_focus() and event.is_action_pressed("ui_down")):
				$%resolutions.grab_focus()

		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			if (event.is_action_pressed("ui_up") and $%vsync_button.has_focus()) \
			or (event.is_action_pressed("ui_down") and $%back_button.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")


func _on_vsync_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		$%vsync_button.text = "V-Sync: On"
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		$%vsync_button.text = "V-Sync: Off"
	
	_config.set_value("Settings", "vsync", DisplayServer.window_get_vsync_mode())


func _on_fullscreen_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		$%fullscreen_button.text = "Fullscreen: On"
		$%resolutions.set_disabled(true)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		$%fullscreen_button.text = "Fullscreen: Off"
		$%resolutions.set_disabled(false)
		_on_resolutions_item_selected($%resolutions.get_selected())
	
	_config.set_value("Settings", "fullscreen", DisplayServer.window_get_mode())


func _on_resolutions_toggled(_button_pressed):
	if Input.is_action_pressed("ui_cancel"):
		AudioManager.play_sfx("menu_back")
	if Input.is_action_pressed("ui_accept"):
		AudioManager.play_sfx("menu_confirm")


func _on_resolutions_item_focused(_index):
	AudioManager.play_sfx("menu_cursor")


func _on_resolutions_item_selected(index):
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
	AudioManager.play_sfx("menu_confirm")
	if Globals.is_in_debug_mode:
		Globals.is_in_debug_mode = false
		get_tree().set_debug_collisions_hint(false)
		$%debug_mode.text = "Debug mode: Off"
	else:
		Globals.is_in_debug_mode = true
		get_tree().set_debug_collisions_hint(true)
		$%debug_mode.text = "Debug mode: On"


func _on_view_controls_pressed():
	AudioManager.play_sfx("menu_confirm")
	$settings_menu.hide()
	$controls_menu.show()


func _on_back_button_pressed():
	AudioManager.play_sfx("menu_back")
	_config.save(Constant.SETTINGS_FILE)
	hide()


func _load_settings():
	_config.load(Constant.SETTINGS_FILE)

	if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
		$%vsync_button.text = "V-Sync: Off"
	else:
		$%vsync_button.text = "V-Sync: On"
	
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		$%fullscreen_button.text = "Fullscreen: Off"
		$%resolutions.set_disabled(false)
	else:
		$%fullscreen_button.text = "Fullscreen: On"
		$%resolutions.set_disabled(true)

	var resolution = _config.get_value("Settings", "resolution")
	if resolution == Vector2i(1920, 1080):
		$%resolutions.select(2)
	elif resolution == Vector2i(1600, 900):
		$%resolutions.select(1)
	elif resolution == Vector2i(1280, 720):
		$%resolutions.select(0)

	if Globals.is_in_debug_mode:
		$%debug_mode.text = "Debug mode: On"
	else:
		$%debug_mode.text = "Debug mode: Off"

