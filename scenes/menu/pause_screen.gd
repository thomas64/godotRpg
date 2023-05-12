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


func _on_load_menu_hidden():
	$pause_menu.show()
	$pause_menu/load_button.grab_focus()


func _on_settings_menu_hidden():
	$pause_menu.show()
	$pause_menu/settings_button.grab_focus()


func _on_audio_menu_hidden():
	$pause_menu.show()
	$pause_menu/audio_button.grab_focus()

