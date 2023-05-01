extends Control


func on_open():
	$Timer.start()


func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		if visible:
			accept_event()
			_close_credits()


func _on_credits_scroll():
	position.y -= 1.0


func _close_credits():
	AudioManager.play_sfx("menu_back")
	hide()
	$Timer.stop()
	position.y = get_viewport().size.y
	$%main_menu.show()
	$%main_menu/credits_button.grab_focus()

