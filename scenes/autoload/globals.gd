extends Node


var is_in_debug_mode: bool = false

var fog_of_war: Dictionary = {}


func update_fow(map_name: String, player_position: Vector2i):
	var rounded_position: Vector2i = (player_position / 100.0).round()
	if fog_of_war.has(map_name):
		var positions: Array = fog_of_war[map_name]
		if not positions.has(rounded_position):
			positions.append(rounded_position)
			fog_of_war[map_name] = positions
	else:
		fog_of_war[map_name] = [rounded_position]

