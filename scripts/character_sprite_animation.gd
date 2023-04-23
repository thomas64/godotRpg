extends Sprite2D


var _direction: int
var _move_speed: int


func animate():
	_direction = get_parent().direction
	_move_speed = get_parent().move_speed

	_set_animation_speed()
	_set_animation()


func _set_animation_speed():
	match _move_speed:
		Constant.MOVE_SPEED_1: $AnimationPlayer.speed_scale = 0.5
		Constant.MOVE_SPEED_2: $AnimationPlayer.speed_scale = 1
		Constant.MOVE_SPEED_3: $AnimationPlayer.speed_scale = 1.33
		Constant.MOVE_SPEED_4: $AnimationPlayer.speed_scale = 0
		_:						$AnimationPlayer.speed_scale = 0


func _set_animation():
	if _direction == Direction.NORTH and _move_speed > Constant.MOVE_SPEED_0:
		$AnimationPlayer.play("north_moving")
	elif _direction == Direction.SOUTH and _move_speed > Constant.MOVE_SPEED_0:
		$AnimationPlayer.play("south_moving")
	elif _direction == Direction.WEST and _move_speed > Constant.MOVE_SPEED_0:
		$AnimationPlayer.play("west_moving")
	elif _direction == Direction.EAST and _move_speed > Constant.MOVE_SPEED_0:
		$AnimationPlayer.play("east_moving")
	else:
		$AnimationPlayer.stop()
		match _direction:
			Direction.NORTH: frame = 10
			Direction.SOUTH: frame = 1
			Direction.WEST: frame = 4
			Direction.EAST: frame = 7

