extends Control


func _ready():
	AudioManager.play_one("bgm_brave")
	$main_menu/start_button.grab_focus()


func _input(event):
	if event is InputEventMouse:
		accept_event()
		return
	
	if event.is_action_pressed("ui_focus_prev") or event.is_action_pressed("ui_focus_next"):
		accept_event()
		return


func _on_load_menu_hidden():
	$main_menu.show()
	$main_menu/start_button.grab_focus()


func _on_settings_menu_hidden():
	$main_menu.show()
	$main_menu/settings_button.grab_focus()


func _on_audio_menu_hidden():
	$main_menu.show()
	$main_menu/audio_button.grab_focus()


func _on_credits_scroll_hidden():
	$main_menu.show()
	$main_menu/credits_button.grab_focus()

