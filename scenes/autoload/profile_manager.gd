extends Node


const _PROFILE_SAVES: Dictionary = {
	1: "user://save1.dat",
	2: "user://save2.dat",
	3: "user://save3.dat"
}

var _current_save_path: String
var _current_profile_name: String
var _current_save_date: String
var _current_map: String


func create_profile(profile_name: String, selected_profile: int) -> String:
	_current_save_path = _get_save_file(selected_profile)
	_current_profile_name = profile_name
	_current_save_date = _get_current_date()
	_current_map = "honeywood_forest_path"
	Globals.history_player_positions = {}
	_write_file()
	return _current_map


func save_profile():
	_current_save_date = _get_current_date()
	_current_map = get_tree().root.get_node("world").get_children().front().name
	_write_file()


func load_profile(selected_profile: int) -> String:
	_current_save_path = _get_save_file(selected_profile)
	var file = FileAccess.open(_current_save_path, FileAccess.READ)
	_current_profile_name = file.get_var()
	_current_save_date = file.get_var()
	_current_map = file.get_var()
	Globals.history_player_positions = file.get_var()
	return _current_map


func delete_profile(selected_profile: int):
	DirAccess.remove_absolute(_get_save_file(selected_profile))


func get_visual_profile_line(selected_profile: int) -> String:
	if does_file_path_exist_for(selected_profile):
		var save_path: String = _get_save_file(selected_profile)
		var file = FileAccess.open(save_path, FileAccess.READ)
		var profile_name = file.get_var()
		var save_date = file.get_var()
		return "%s [%s]" % [profile_name, save_date]
	else:
		return "%s [...]" % selected_profile


func does_file_path_exist_for(selected_profile: int) -> bool:
	return FileAccess.file_exists(_get_save_file(selected_profile))


func _write_file():
	var file = FileAccess.open(_current_save_path, FileAccess.WRITE)
	file.store_var(_current_profile_name)
	file.store_var(_current_save_date)
	file.store_var(_current_map)
	file.store_var(Globals.history_player_positions)


func _get_save_file(selected_profile: int) -> String:
	return _PROFILE_SAVES.get(selected_profile)


func _get_current_date() -> String:
	return Time.get_datetime_string_from_system().replace("T", " ").left(-3)

