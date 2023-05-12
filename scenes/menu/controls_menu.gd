extends Control


func _input(event):
	if visible:

		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") \
		or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			accept_event()
			return

		if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
			accept_event()
			AudioManager.play_sfx("menu_back")
			hide()
			$%settings_menu.show()
			$%view_controls.grab_focus()
			return

