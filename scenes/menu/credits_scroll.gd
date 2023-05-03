extends Control


func on_open():
	position.y = Constant.SCREEN_HEIGHT
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
	$%main_menu.show()
	$%main_menu/credits_button.grab_focus()

