extends Control


func _on_pause_screen_visibility_changed():
	if visible:
		$pause_menu/continue_button.grab_focus()


func _input(event):
	if event is InputEventMouse:
		accept_event()
		return

	if event.is_action_pressed("ui_focus_prev") or event.is_action_pressed("ui_focus_next"):
		accept_event()
		return

	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
		if $settings_menu/controls_menu.visible:
			return
		_handle_up_down_sound(event)


func _on_settings_menu_hidden():
	$pause_menu.show()
	$pause_menu/settings_button.grab_focus()


func _on_audio_menu_hidden():
	$pause_menu.show()
	$pause_menu/audio_button.grab_focus()


func _handle_up_down_sound(event):
	if (event.is_action_pressed("ui_up") and (
		$pause_menu/continue_button.has_focus() or
		$settings_menu/settings_menu/vsync_button.has_focus() or
		$audio_menu/bgm_slider.has_focus()
		)
	) \
	or (event.is_action_pressed("ui_down") and (
		$pause_menu/main_button.has_focus() or
		$settings_menu/settings_menu/back_button.has_focus() or
		$audio_menu/back_button.has_focus()
		)
	):
		AudioManager.play_sfx("menu_error")
	else:
		AudioManager.play_sfx("menu_cursor")

