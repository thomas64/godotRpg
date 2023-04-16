extends AnimatedSprite2D


func update(direction: int, move_speed: int, velocity: Vector2):
	_set_animation_speed(move_speed)
	_set_animation(direction, velocity)


func _set_animation_speed(move_speed: int):
	if (move_speed == Constant.MOVE_SPEED_1):
		speed_scale = 0.5
	elif (move_speed == Constant.MOVE_SPEED_2):
		speed_scale = 1.0
	elif (move_speed == Constant.MOVE_SPEED_3):
		speed_scale = 1.5
	elif (move_speed == Constant.MOVE_SPEED_4):
		speed_scale = 0.0


func _set_animation(direction: int, velocity: Vector2):
	if direction == Direction.NORTH and velocity.y != 0:
		play("north_moving")
	elif direction == Direction.SOUTH and velocity.y != 0:
		play("south_moving")
	elif direction == Direction.WEST and velocity.x != 0:
		play("west_moving")
	elif direction == Direction.EAST and velocity.x != 0:
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
