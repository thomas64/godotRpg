extends Control


func _input(event):
	if visible:

		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			if (event.is_action_pressed("ui_up") and $start_button.has_focus()) \
			or (event.is_action_pressed("ui_down") and $exit_button.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")


func _on_start_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	hide()
	$%load_menu.show()
	$%load_menu.on_open_from_main()


func _on_settings_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	hide()
	$%settings_menu.show()
	$%settings_menu.on_open()


func _on_audio_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	hide()
	$%audio_menu.show()
	$%audio_menu.on_open()


func _on_credits_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	hide()
	$%credits_scroll.show()
	$%credits_scroll.on_open()


func _on_exit_button_pressed():
	get_tree().quit()

