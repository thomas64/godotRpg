extends Control


func _on_start_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	var run_after_fade: Callable = func():
		get_tree().change_scene_to_file("res://maps/honeywood_forest_path.tscn")
		TransitionScreen.fade_to_normal()

	TransitionScreen.fade_to_black()
	AudioManager.fade_and_run("bgm_brave", run_after_fade)


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

