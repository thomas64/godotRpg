extends Control


func _on_start_button_pressed():
	var run_after_fade: Callable = func(): 
		get_tree().change_scene_to_file("res://maps/honeywood_forest_path.tscn")
		TransitionScreen.fade_to_normal()

	TransitionScreen.fade_to_black()
	AudioManager.fade_and_run("bgm_brave", run_after_fade)


func _on_settings_button_pressed():
	hide()
	$%settings_menu.show()
	$%settings_menu.on_open()


func _on_audio_button_pressed():
	pass


func _on_credits_button_pressed():
	hide()
	$%credits.show()
	$%credits/Timer.start()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_credits_scroll():
	$%credits.position.y -= 1


func close_credits():
	accept_event()
	$%credits.hide()
	$%credits/Timer.stop()
	$%credits.position.y = get_viewport().size.y
	show()
	$credits_button.grab_focus()

