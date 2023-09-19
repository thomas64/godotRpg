extends Control


var _selected_profile: int = 1

@onready var _profile_labels: Dictionary = {
	1: $%profile1,
	2: $%profile2,
	3: $%profile3
}

func on_open_from_main():
	_load_profiles_visual()
	$%load_button.hide()
	$%start_button.show()
	$%start_button.grab_focus()


func on_open_from_pause():
	_load_profiles_visual()
	$%start_button.hide()
	$%load_button.show()
	$%load_button.grab_focus()


func _input(event):
	if visible and $load_menu.visible:
	
		if event.is_action_pressed("ui_cancel"):
			accept_event()
			_on_back_button_pressed()
			return
		
		if event.is_action_pressed("ui_delete"):
			accept_event()
			$%delete_button.grab_focus()
			_on_delete_button_pressed()
			return
		
		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
			if (event.is_action_pressed("ui_left") and $%start_button.has_focus()) \
			or (event.is_action_pressed("ui_left") and $%load_button.has_focus()) \
			or (event.is_action_pressed("ui_right") and $%back_button.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")
		
		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			if event.is_action_pressed("ui_up"):
				if _selected_profile == 1:
					AudioManager.play_sfx("menu_error")
				else:
					AudioManager.play_sfx("menu_cursor")
					_selected_profile -= 1
			elif event.is_action_pressed("ui_down"):
				if _selected_profile == 3:
					AudioManager.play_sfx("menu_error")
				else:
					AudioManager.play_sfx("menu_cursor")
					_selected_profile += 1


func _process(_delta):
	_update_font_colors_when_profile_has_focus()


################################################################################


func _on_load_button_pressed():
	if ProfileManager.does_file_path_exist_for(_selected_profile):
		AudioManager.play_sfx("menu_confirm")
		$%confirm_load.popup_centered()
	else:
		AudioManager.play_sfx("menu_error")


func _on_start_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	if ProfileManager.does_file_path_exist_for(_selected_profile):
		var current_map: String = ProfileManager.load_profile(_selected_profile)
		AudioManager.fade("bgm_brave")
		SceneChanger.with_fade_to_world_to_map(current_map)
	else:
		$load_menu.hide()
		$new_menu.show()
		$new_menu.on_open(_selected_profile)


func _on_delete_button_pressed():
	if ProfileManager.does_file_path_exist_for(_selected_profile):
		AudioManager.play_sfx("menu_confirm")
		$%confirm_delete.popup_centered()
	else:
		AudioManager.play_sfx("menu_error")


func _on_back_button_pressed():
	AudioManager.play_sfx("menu_back")
	hide()


################################################################################


func _on_confirm_load_confirmed():
	AudioManager.stop_all()
	AudioManager.play_sfx("menu_confirm")
	var current_map: String = ProfileManager.load_profile(_selected_profile)
	SceneChanger.with_fade_to_world_to_map(current_map)
	get_tree().paused = false


func _on_confirm_delete_confirmed():
	AudioManager.play_sfx("menu_confirm")
	ProfileManager.delete_profile(_selected_profile)
	_load_profiles_visual()


func _on_new_menu_hidden():
	$load_menu.show()
	$%start_button.grab_focus()


################################################################################


func _load_profiles_visual():
	var i: int = 1
	for label in _profile_labels.values():
		label.text = ProfileManager.get_visual_profile_line(i)
		i += 1 


func _update_font_colors_when_profile_has_focus():
	var default: Color = get_theme_color("font_color", "Button")
	var focus: Color = get_theme_color("font_focus_color", "Button")

	for label in _profile_labels.values():
		label.add_theme_color_override("font_color", default)
	_profile_labels.get(_selected_profile).add_theme_color_override("font_color", focus)

