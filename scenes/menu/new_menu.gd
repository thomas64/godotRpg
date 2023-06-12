extends Control


var _selected_profile: int = 0
var _profile_name: String = ""


func on_open(selected_profile: int):
	_selected_profile = selected_profile
	$input_field.grab_focus()


func _input(event):
	if visible:
		
		if event.is_action_pressed("ui_cancel"):
			accept_event()
			_on_back_button_pressed()
			return
		
		if $input_field.has_focus():
			if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right") \
			or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
				accept_event()
				return
		
		if event.is_action_pressed("ui_down"):
			accept_event()
			return
		
		if event.is_action_pressed("ui_up"):
			AudioManager.play_sfx("menu_cursor")
		
		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
			if (event.is_action_pressed("ui_left") and $%start_button.has_focus()) \
			or (event.is_action_pressed("ui_right") and $%back_button.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")


func _on_input_field_text_changed(new_text):
	var old_caret_column = $input_field.caret_column
	var word = ''
	var regex := RegEx.new()
	regex.compile("[A-Za-z0-9]")
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	$input_field.text = word
	$input_field.caret_column = old_caret_column
	if word == new_text:
		AudioManager.play_sfx("menu_typing")


func _on_input_field_text_submitted(new_text):
	_profile_name = new_text
	AudioManager.play_sfx("menu_confirm")
	$%start_button.grab_focus()


func _on_start_button_pressed():
	AudioManager.play_sfx("menu_confirm")
	var save_data: SaveData = ProfileManager.create_profile(_profile_name, _selected_profile)
	AudioManager.fade("bgm_brave")
	SceneChanger.with_fade_to_world_to_map(save_data.current_map)


func _on_back_button_pressed():
	_selected_profile = 0
	_profile_name = ""
	AudioManager.play_sfx("menu_back")
	hide()

