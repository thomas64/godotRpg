extends Control


func _input(event):
	if event.is_action_pressed("pause"):
		accept_event()
		_on_continue_button_pressed()


func _on_continue_button_pressed():
	AudioManager.play_sfx("menu_back")
	get_parent().get_parent().hide()
	get_tree().paused = false


func _on_load_button_pressed():
	AudioManager.stop_all()
	AudioManager.play_sfx("menu_confirm")
	SceneChanger.with_fade_to("res://scenes/world/world.tscn")
	get_tree().paused = false


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
	AudioManager.stop_all()
	AudioManager.play_sfx("menu_confirm")
	SceneChanger.with_fade_to("res://scenes/menu/menu_screen.tscn")
	get_tree().paused = false

