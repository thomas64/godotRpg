extends AnimatedSprite2D


func update(direction: int, move_speed: int):
	_set_animation_speed(move_speed)
	_set_animation(direction, move_speed)


func _set_animation_speed(move_speed: int):
	match move_speed:
		Constant.MOVE_SPEED_1: speed_scale = 0.5
		Constant.MOVE_SPEED_2: speed_scale = 1.0
		Constant.MOVE_SPEED_3: speed_scale = 1.5
		Constant.MOVE_SPEED_4: speed_scale = 0
		_:						speed_scale = 0


func _set_animation(direction: int, move_speed: int):
	if direction == Direction.NORTH and move_speed > Constant.MOVE_SPEED_0:
		play("north_moving")
	elif direction == Direction.SOUTH and move_speed > Constant.MOVE_SPEED_0:
		play("south_moving")
	elif direction == Direction.WEST and move_speed > Constant.MOVE_SPEED_0:
		play("west_moving")
	elif direction == Direction.EAST and move_speed > Constant.MOVE_SPEED_0:
		play("east_moving")
	elif direction == Direction.NORTH:
		play("north_idle")
	elif direction == Direction.SOUTH:
		play("south_idle")
	elif direction == Direction.WEST:
		play("west_idle")
	elif direction == Direction.EAST:
		play("east_idle")
	else:
		assert(false, "No animation to set.")
