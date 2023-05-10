extends Control


func _ready():
	AudioManager.play_one("bgm_brave")
	$main_menu/start_button.grab_focus()


func _input(event):
	if event is InputEventMouse:
		accept_event()
		return
	
	if event.is_action_pressed("ui_focus_prev") or event.is_action_pressed("ui_focus_next"):
		accept_event()
		return

	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		if $credits_scroll.visible or $settings_menu/controls_menu.visible:
			return

		if (event.is_action_pressed("ui_up") and (
			$main_menu/start_button.has_focus() or
			$settings_menu/settings_menu/vsync_button.has_focus() or
			$audio_menu/bgm_slider.has_focus()
			)
		) \
		or (event.is_action_pressed("ui_down") and (
			$main_menu/exit_button.has_focus() or
			$settings_menu/settings_menu/back_button.has_focus() or
			$audio_menu/back_button.has_focus()
			)
		):
			AudioManager.play_sfx("menu_error")
		else:
			AudioManager.play_sfx("menu_cursor")


func _on_load_menu_hidden():
	$main_menu.show()
	$main_menu/start_button.grab_focus()


func _on_settings_menu_hidden():
	$main_menu.show()
	$main_menu/settings_button.grab_focus()


func _on_audio_menu_hidden():
	$main_menu.show()
	$main_menu/audio_button.grab_focus()

