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
	hide()
	$%audio_menu.show()
	$%audio_menu.on_open()


func _on_credits_button_pressed():
	hide()
	$%credits_scroll.show()
	$%credits_scroll/Timer.start()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_credits_scroll():
	$%credits_scroll.position.y -= 1


func close_credits():
	$%credits_scroll.hide()
	$%credits_scroll/Timer.stop()
	$%credits_scroll.position.y = get_viewport().size.y
	show()
	$credits_button.grab_focus()

