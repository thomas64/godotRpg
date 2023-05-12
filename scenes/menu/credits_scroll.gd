extends Control


func on_open():
	position.y = Constant.SCREEN_HEIGHT
	$Timer.start()


func _input(event):
	if visible:

		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") \
		or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			accept_event()
			return

		if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
			accept_event()
			_close_credits()
			return


func _on_credits_scroll():
	position.y -= 1.0


func _close_credits():
	AudioManager.play_sfx("menu_back")
	$Timer.stop()
	hide()

