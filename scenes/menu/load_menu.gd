extends Control


const _SAVE_FILE_1: String = "user://save1.tres"
const _SAVE_FILE_2: String = "user://save2.tres"
const _SAVE_FILE_3: String = "user://save3.tres"

var _selected_profile: int = 1

@onready var _profiles: Dictionary = {
	1: $%profile1,
	2: $%profile2,
	3: $%profile3
}


func on_open():
	_load_profiles()
	$%start.grab_focus()


func _input(event):
	if visible:

		if event.is_action_pressed("ui_cancel"):
			accept_event()
			_on_back_pressed()
			return
		
		if event.is_action_pressed("ui_delete"):
			accept_event()
			$%delete.grab_focus()
			_on_delete_pressed()
			return
			
		if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
			if (event.is_action_pressed("ui_left") and $%start.has_focus()) \
			or (event.is_action_pressed("ui_right") and $%back.has_focus()):
				AudioManager.play_sfx("menu_error")
			else:
				AudioManager.play_sfx("menu_cursor")

		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
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


func _on_start_pressed():
	AudioManager.play_sfx("menu_confirm")
	AudioManager.fade("bgm_brave")
	# todo, continue here:
	if not ResourceLoader.exists(_SAVE_FILE_1):
		var saveData = SaveData.new()
		saveData.profile_name = "Thomas"
		saveData.save_date = Time.get_datetime_string_from_system().replace("T", " ").left(-3)
		ResourceSaver.save(saveData, _SAVE_FILE_1)
	SceneChanger.with_fade_to_world_to_map("honeywood_forest_path")


func _on_delete_pressed():
	if (_selected_profile == 1 and ResourceLoader.exists(_SAVE_FILE_1)) \
	or (_selected_profile == 2 and ResourceLoader.exists(_SAVE_FILE_2)) \
	or (_selected_profile == 3 and ResourceLoader.exists(_SAVE_FILE_3)):
		AudioManager.play_sfx("menu_confirm")
		$ConfirmationDialog.popup_centered()
		$ConfirmationDialog.get_cancel_button().grab_focus()
	else:
		AudioManager.play_sfx("menu_error")


func _on_back_pressed():
	AudioManager.play_sfx("menu_back")
	hide()


func _on_confirmation_dialog_confirmed():
	AudioManager.play_sfx("menu_confirm")
	match _selected_profile:
		1: DirAccess.remove_absolute(_SAVE_FILE_1)
		2: DirAccess.remove_absolute(_SAVE_FILE_2)
		3: DirAccess.remove_absolute(_SAVE_FILE_3)
	_load_profiles()


func _load_profiles():
	$%profile1.text = _get_profile_text(_SAVE_FILE_1) if ResourceLoader.exists(_SAVE_FILE_1) else "1 [...]"
	$%profile2.text = _get_profile_text(_SAVE_FILE_2) if ResourceLoader.exists(_SAVE_FILE_2) else "2 [...]"
	$%profile3.text = _get_profile_text(_SAVE_FILE_3) if ResourceLoader.exists(_SAVE_FILE_3) else "3 [...]"


func _get_profile_text(save_file: String) -> String:
	var save_data := load(save_file) as SaveData
	return "%s [%s]" % [save_data.profile_name, save_data.save_date]


func _update_font_colors_when_profile_has_focus():
	var default: Color = get_theme_color("font_color", "Button")
	var focus: Color = get_theme_color("font_focus_color", "Button")

	for profile in _profiles.values():
		profile.add_theme_color_override("font_color", default)
	_profiles.get(_selected_profile).add_theme_color_override("font_color", focus)

