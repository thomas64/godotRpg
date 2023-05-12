extends Control


func _input(event):
	
	if visible and (event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept")):
		accept_event()
		AudioManager.play_sfx("menu_back")
		hide()
		$%settings_menu.show()
		$%view_controls.grab_focus()
		return

