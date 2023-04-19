extends AnimatedSprite2D


var _direction: int
var _move_speed: int


func update():
	_direction = get_parent().direction
	_move_speed = get_parent().move_speed

	_set_animation_speed()
	_set_animation()


func _set_animation_speed():
	match _move_speed:
		Constant.MOVE_SPEED_1: speed_scale = 0.5
		Constant.MOVE_SPEED_2: speed_scale = 1.0
		Constant.MOVE_SPEED_3: speed_scale = 1.5
		Constant.MOVE_SPEED_4: speed_scale = 0
		_:						speed_scale = 0


func _set_animation():
	if _direction == Direction.NORTH and _move_speed > Constant.MOVE_SPEED_0:
		play("north_moving")
	elif _direction == Direction.SOUTH and _move_speed > Constant.MOVE_SPEED_0:
		play("south_moving")
	elif _direction == Direction.WEST and _move_speed > Constant.MOVE_SPEED_0:
		play("west_moving")
	elif _direction == Direction.EAST and _move_speed > Constant.MOVE_SPEED_0:
		play("east_moving")
	elif _direction == Direction.NORTH:
		play("north_idle")
	elif _direction == Direction.SOUTH:
		play("south_idle")
	elif _direction == Direction.WEST:
		play("west_idle")
	elif _direction == Direction.EAST:
		play("east_idle")

