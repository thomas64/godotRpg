extends Control


const _PROFILE_SAVES: Dictionary = {
	1: "user://save1.tres",
	2: "user://save2.tres",
	3: "user://save3.tres"
}

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
	if ResourceLoader.exists(get_save_file()):
		AudioManager.play_sfx("menu_confirm")
		$%confirm_load.popup_centered()
	else:
		AudioManager.play_sfx("menu_error")


func _on_start_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	var save_file: String = get_save_file()
	if ResourceLoader.exists(save_file):
		var save_data := load(save_file) as SaveData
		AudioManager.fade("bgm_brave")
		Globals.save_file = save_file
		SceneChanger.with_fade_to_world_to_map(save_data.current_map)
	else:
		$load_menu.hide()
		$new_menu.show()
		$new_menu.on_open()


func _on_delete_button_pressed():
	if ResourceLoader.exists(get_save_file()):
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
	var save_file: String = get_save_file()
	var save_data := load(save_file) as SaveData
	Globals.save_file = save_file
	SceneChanger.with_fade_to_world_to_map(save_data.current_map)
	get_tree().paused = false


func _on_confirm_delete_confirmed():
	AudioManager.play_sfx("menu_confirm")
	DirAccess.remove_absolute(get_save_file())
	_load_profiles_visual()


func _on_new_menu_hidden():
	$load_menu.show()
	$%start_button.grab_focus()


################################################################################


func get_save_file() -> String:
	return _PROFILE_SAVES.get(_selected_profile)


func _load_profiles_visual():
	var i: int = 1
	for label in _profile_labels.values():
		var save_file: String = _PROFILE_SAVES.get(i)
		if ResourceLoader.exists(save_file):
			var save_data := load(save_file) as SaveData
			label.text = "%s [%s]" % [save_data.profile_name, save_data.save_date]
		else:
			label.text = "%s [...]" % i
		i += 1 


func _update_font_colors_when_profile_has_focus():
	var default: Color = get_theme_color("font_color", "Button")
	var focus: Color = get_theme_color("font_focus_color", "Button")

	for label in _profile_labels.values():
		label.add_theme_color_override("font_color", default)
	_profile_labels.get(_selected_profile).add_theme_color_override("font_color", focus)

