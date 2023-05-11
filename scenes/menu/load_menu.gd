extends Control


const _PROFILE_SAVES: Dictionary = {
	1: "user://save1.tres",
	2: "user://save2.tres",
	3: "user://save3.tres"
}

var _selected_profile: int = 1
var _profile_name: String = ""

@onready var _profile_labels: Dictionary = {
	1: $%profile1,
	2: $%profile2,
	3: $%profile3
}


func on_open():
	_load_profiles_visual()
	$%load_start.grab_focus()


func _input(event):
	if visible:
	
		if $load_menu.visible and event.is_action_pressed("ui_cancel"):
			accept_event()
			_on_load_back_pressed()
			return
		
		if $new_menu.visible and event.is_action_pressed("ui_cancel"):
			accept_event()
			_on_new_back_pressed()
			return
		
		if $load_menu.visible and event.is_action_pressed("ui_delete"):
			accept_event()
			$%load_delete.grab_focus()
			_on_delete_pressed()
			return
		
		if $%new_edit.has_focus():
			if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") \
			or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
				accept_event()
				return
		
		if $new_menu.visible:
			if event.is_action_pressed("ui_down"):
				accept_event()
				return
		
		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
			if (event.is_action_pressed("ui_left") and $%load_start.has_focus()) \
			or (event.is_action_pressed("ui_left") and $%new_start.has_focus()) \
			or (event.is_action_pressed("ui_right") and $%load_back.has_focus()) \
			or (event.is_action_pressed("ui_right") and $%new_back.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")
		
		if $load_menu.visible and (event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
			if event.is_action_pressed("ui_up"):
				if _selected_profile == 1:
					AudioManager.play_sfx("menu_error")
				else:
					_selected_profile -= 1
			elif event.is_action_pressed("ui_down"):
				if _selected_profile == 3:
					AudioManager.play_sfx("menu_error")
				else:
					_selected_profile += 1
			else:
				AudioManager.play_sfx("menu_cursor")


func _process(_delta):
	_update_font_colors_when_profile_has_focus()


func _on_load_start_pressed():
	AudioManager.play_sfx("menu_confirm")
	var save_file: String = _get_save_file()
	if ResourceLoader.exists(save_file):
		var save_data := load(save_file) as SaveData
		AudioManager.fade("bgm_brave")
		SceneChanger.with_fade_to_world_to_map(save_data.current_map)
	else:
		$load_menu.hide()
		$new_menu.show()
		$%new_edit.grab_focus()


func _on_delete_pressed():
	if ResourceLoader.exists(_get_save_file()):
		AudioManager.play_sfx("menu_confirm")
		$%confirm_delete.popup_centered()
		$%confirm_delete.get_cancel_button().grab_focus()
	else:
		AudioManager.play_sfx("menu_error")


func _on_load_back_pressed():
	AudioManager.play_sfx("menu_back")
	hide()


func _on_line_edit_text_changed(new_text):
	var old_caret_column = $%new_edit.caret_column
	var word = ''
	var regex := RegEx.new()
	regex.compile("[A-Za-z0-9]")
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	$%new_edit.text = word
	$%new_edit.caret_column = old_caret_column
	if word == new_text:
		AudioManager.play_sfx("menu_typing")


func _on_new_edit_text_submitted(new_text):
	_profile_name = new_text
	AudioManager.play_sfx("menu_confirm")
	$%new_start.grab_focus()


func _on_confirm_delete_confirmed():
	AudioManager.play_sfx("menu_confirm")
	DirAccess.remove_absolute(_get_save_file())
	_load_profiles_visual()


func _on_new_start_pressed():
	var save_data := SaveData.new()
	save_data.profile_name = _profile_name
	save_data.save_date = Time.get_datetime_string_from_system().replace("T", " ").left(-3)
	save_data.current_map = "honeywood_forest_path"
	ResourceSaver.save(save_data, _get_save_file())
	AudioManager.fade("bgm_brave")
	SceneChanger.with_fade_to_world_to_map(save_data.current_map)


func _on_new_back_pressed():
	_profile_name = ""
	AudioManager.play_sfx("menu_back")
	$new_menu.hide()
	$load_menu.show()
	$%load_start.grab_focus()


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


func _get_save_file() -> String:
	return _PROFILE_SAVES.get(_selected_profile)


func _update_font_colors_when_profile_has_focus():
	var default: Color = get_theme_color("font_color", "Button")
	var focus: Color = get_theme_color("font_focus_color", "Button")

	for label in _profile_labels.values():
		label.add_theme_color_override("font_color", default)
	_profile_labels.get(_selected_profile).add_theme_color_override("font_color", focus)

