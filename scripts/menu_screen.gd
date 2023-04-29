extends Control


func _ready():
	AudioManager.play_one("bgm_brave")
	$%start_button.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_up") \
	or event.is_action_pressed("ui_down") \
	or event.is_action_pressed("ui_focus_prev") \
	or event.is_action_pressed("ui_focus_next"):

		if $%credits.visible:
			return

		if ((event.is_action_pressed("ui_up") or event.is_action_pressed("ui_focus_prev")) \
				and ($%start_button.has_focus() or $%vsync_button.has_focus())) \
		or ((event.is_action_pressed("ui_down") or event.is_action_pressed("ui_focus_next")) \
				and ($%exit_button.has_focus() or $%back_button.has_focus())):
			AudioManager.play_sfx("menu_error")
		else:
			AudioManager.play_sfx("menu_cursor")

	if event.is_action_pressed("ui_accept"):

		if $%credits.visible:
			$main_menu.close_credits()

		AudioManager.play_sfx("menu_confirm")

