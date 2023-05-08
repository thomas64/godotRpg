extends Node


var _config = ConfigFile.new()


func _ready():
	_config.load(Constant.SETTINGS_FILE)

	var bgm_volume: float = _config.get_value("Audio", "bgm_volume", 1)
	var bgs_volume: float = _config.get_value("Audio", "bgs_volume", 1)
	var sfx_volume: float = _config.get_value("Audio", "sfx_volume", 1)

	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgm"), linear_to_db(bgm_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("bgs"), linear_to_db(bgs_volume))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("sfx"), linear_to_db(sfx_volume))

	var fullscreen = _config.get_value("Settings", "fullscreen", DisplayServer.WINDOW_MODE_WINDOWED)
	var vsync = _config.get_value("Settings", "vsync", DisplayServer.VSYNC_ENABLED)
	var resolution = _config.get_value("Settings", "resolution", Vector2i(1920, 1080))

	DisplayServer.window_set_mode(fullscreen)
	DisplayServer.window_set_vsync_mode(vsync)
	DisplayServer.window_set_size(resolution)
	get_viewport().size = resolution

	_config.set_value("Audio", "bgm_volume", bgm_volume)
	_config.set_value("Audio", "bgs_volume", bgs_volume)
	_config.set_value("Audio", "sfx_volume", sfx_volume)

	_config.set_value("Settings", "fullscreen", fullscreen)
	_config.set_value("Settings", "vsync", vsync)
	_config.set_value("Settings", "resolution", resolution)

	_config.save(Constant.SETTINGS_FILE)

