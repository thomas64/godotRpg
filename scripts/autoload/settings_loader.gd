extends Node


var _config = ConfigFile.new()


func _ready():
	_config.load("res://settings.cfg")

	var bgm_bus_index: int = AudioServer.get_bus_index("bgm")
	var bgs_bus_index: int = AudioServer.get_bus_index("bgs")
	var sfx_bus_index: int = AudioServer.get_bus_index("sfx")

	var bgm_volume: float = linear_to_db(_config.get_value("Settings", "bgm_volume", 1))
	var bgs_volume: float = linear_to_db(_config.get_value("Settings", "bgs_volume", 1))
	var sfx_volume: float = linear_to_db(_config.get_value("Settings", "sfx_volume", 1))

	AudioServer.set_bus_volume_db(bgm_bus_index, bgm_volume)
	AudioServer.set_bus_volume_db(bgs_bus_index, bgs_volume)
	AudioServer.set_bus_volume_db(sfx_bus_index, sfx_volume)


	var fullscreen = _config.get_value("Settings", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	var vsync = _config.get_value("Settings", "vsync", DisplayServer.VSYNC_ENABLED)
	var resolution = _config.get_value("Settings", "resolution", Vector2i(1920, 1080))

	DisplayServer.window_set_mode(fullscreen)
	DisplayServer.window_set_vsync_mode(vsync)
	DisplayServer.window_set_size(resolution)
	get_viewport().size = resolution

	_config.set_value("Settings", "fullscreen", fullscreen)
	_config.set_value("Settings", "vsync", vsync)
	_config.set_value("Settings", "resolution", resolution)
	_config.save("res://settings.cfg")

