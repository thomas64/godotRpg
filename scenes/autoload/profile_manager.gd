extends Node


const _PROFILE_SAVES: Dictionary = {
	1: "user://save1.tres",
	2: "user://save2.tres",
	3: "user://save3.tres"
}

var _current_save_path: String


func create_profile(profile_name: String, selected_profile: int) -> SaveData:
	var save_data := SaveData.new()
	save_data.profile_name = profile_name
	save_data.save_date = Time.get_datetime_string_from_system().replace("T", " ").left(-3)
	save_data.current_map = "honeywood_forest_path"
	var save_path: String = get_save_file(selected_profile) 
	ResourceSaver.save(save_data, save_path)
	_current_save_path = save_path
	return save_data


func load_profile(selected_profile: int) -> SaveData:
	var save_path: String = get_save_file(selected_profile)
	var save_data := load(save_path) as SaveData
	_current_save_path = save_path
	return save_data


func delete_profile(selected_profile: int):
	DirAccess.remove_absolute(get_save_file(selected_profile))


func get_visual_profile_line(selected_profile: int) -> String:
	if does_file_path_exist_for(selected_profile):
		var save_path: String = get_save_file(selected_profile)
		var save_data := load(save_path) as SaveData
		return "%s [%s]" % [save_data.profile_name, save_data.save_date]
	else:
		return "%s [...]" % selected_profile


func does_file_path_exist_for(_selected_profile: int) -> bool:
	return ResourceLoader.exists(get_save_file(_selected_profile))


func get_save_file(selected_profile: int) -> String:
	return _PROFILE_SAVES.get(selected_profile)

