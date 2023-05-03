extends Node


var _sounds: Array[AudioStreamPlayer] = []
var _random: RandomNumberGenerator = RandomNumberGenerator.new()
var _last_index: int = -1


func _ready():
	for child in get_children():
		_sounds.append(child)


func play_sound():
	var index: int
	while true:
		index = _random.randi_range(0, _sounds.size() - 1)
		if index != _last_index:
			break
	_last_index = index
	_sounds[index].play()

