extends Control


func _ready():
	AudioManager.play_one("bgm_brave")
	$main_menu/start_button.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_up") \
	or event.is_action_pressed("ui_down"):

		if $credits_quit_button.has_focus():
			return

		if (event.is_action_pressed("ui_up") and $main_menu/start_button.has_focus()) \
		or (event.is_action_pressed("ui_down") and $main_menu/exit_button.has_focus()):
			AudioManager.get_node("menu_error").play()
		else:
			AudioManager.get_node("menu_cursor").play()

	if event.is_action_pressed("ui_accept"):

		AudioManager.get_node("menu_confirm").play()


func _on_start_button_pressed():
	var run_after_fade: Callable = func(): 
		get_tree().change_scene_to_file("res://maps/honeywood_forest_path.tscn")
		TransitionScreen.fade_to_normal()

	TransitionScreen.fade_to_black()
	AudioManager.fade_and_run("bgm_brave", run_after_fade)


func _on_settings_button_pressed():
	pass


func _on_credits_button_pressed():
	$main_menu.hide()
	$credits.show()
	$credits_quit_button.grab_focus()
	$credits/Timer.start()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_credits_scroll():
	$credits.position.y -= 1


func _on_credits_quit_button_pressed():
	$credits.hide()
	$credits/Timer.stop()
	$credits.position.y = get_viewport().size.y
	$main_menu.show()
	$main_menu/credits_button.grab_focus()

