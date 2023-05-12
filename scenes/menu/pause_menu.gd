extends Control


func _input(event):
	if visible:

		if event.is_action_pressed("ui_cancel") or event.is_action_pressed("pause"):
			accept_event()
			_on_continue_button_pressed()
			return

		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			if (event.is_action_pressed("ui_up") and $continue_button.has_focus()) \
			or (event.is_action_pressed("ui_down") and $main_button.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")


func _on_continue_button_pressed():
	AudioManager.play_sfx("menu_back")
	get_parent().get_parent().hide()
	get_tree().paused = false


func _on_load_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	hide()
	$%load_menu.show()
	$%load_menu.on_open_from_pause()


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


func _on_main_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	$ConfirmationDialog.popup_centered()


func _on_confirmation_dialog_confirmed():
	AudioManager.stop_all()
	AudioManager.play_sfx("menu_confirm")
	SceneChanger.with_fade_to_scene("res://scenes/menu/menu_screen.tscn")
	get_tree().paused = false

