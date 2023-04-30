extends Control


func _ready():
	AudioManager.play_one("bgm_brave")
	$main_menu/start_button.grab_focus()


func _input(event):
	if event.is_action_pressed("ui_focus_prev") or event.is_action_pressed("ui_focus_next"):
		accept_event()
		return


	if $audio_menu.visible and not $audio_menu/back_button.has_focus():
		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
			if (event.is_action_pressed("ui_left") \
				and (($audio_menu/bgm_slider.has_focus() and $audio_menu/bgm_slider.value == 0) \
					or ($audio_menu/bgs_slider.has_focus() and $audio_menu/bgs_slider.value == 0) \
					or ($audio_menu/sfx_slider.has_focus() and $audio_menu/sfx_slider.value == 0)
				)
			) \
			or (event.is_action_pressed("ui_right") \
				and (($audio_menu/bgm_slider.has_focus() and $audio_menu/bgm_slider.value == 1) \
					or ($audio_menu/bgs_slider.has_focus() and $audio_menu/bgs_slider.value == 1) \
					or ($audio_menu/sfx_slider.has_focus() and $audio_menu/sfx_slider.value == 1)
				)
			):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")


	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):

		if $credits_scroll.visible:
			return

		if (event.is_action_pressed("ui_up") \
			and ($main_menu/start_button.has_focus()
				or $settings_menu/vsync_button.has_focus()
				or $audio_menu/bgm_slider.has_focus()
			)
		) \
		or (event.is_action_pressed("ui_down") \
			and ($main_menu/exit_button.has_focus()
				or $settings_menu/back_button.has_focus()
				or $audio_menu/back_button.has_focus()
			)
		):
			AudioManager.play_sfx("menu_error")
		else:
			AudioManager.play_sfx("menu_cursor")


	if event.is_action_pressed("ui_accept"):

		if $audio_menu.visible and not $audio_menu/back_button.has_focus():
			return

		if $credits_scroll.visible:
			accept_event()
			$main_menu.close_credits()

		AudioManager.play_sfx("menu_confirm")

