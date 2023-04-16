extends Node


var direction: int = Direction.SOUTH
var move_speed: int = 0
var velocity: Vector2 = Vector2.ZERO

var _press_up: bool = false
var _press_down: bool = false
var _press_left: bool = false
var _press_right: bool = false

var _press_ctrl: bool = false
var _press_shift: bool = false

var _time_up: int = 0
var _time_down: int = 0
var _time_left: int = 0
var _time_right: int = 0


func update():
	_process_key_input()
	_process_key_down_time()
	_set_move_speed()
	_set_direction()
	_set_velocity()


func _process_key_input():
	_press_up = Input.is_action_pressed("ui_up")
	_press_down = Input.is_action_pressed("ui_down")
	_press_left = Input.is_action_pressed("ui_left")
	_press_right = Input.is_action_pressed("ui_right")
	_press_ctrl = Input.is_action_pressed("crouch")
	_press_shift = Input.is_action_pressed("run")


func _process_key_down_time():
	if _press_up:
		_time_up += 1
	else:
		_time_up = 0
	if _press_down:
		_time_down += 1
	else:
		_time_down = 0
	if _press_left:
		_time_left += 1
	else:
		_time_left = 0
	if _press_right:
		_time_right += 1
	else:
		_time_right = 0


func _set_move_speed():
	if _press_ctrl and _press_shift:
		move_speed = Constant.MOVE_SPEED_4
	elif _press_shift:
		move_speed = Constant.MOVE_SPEED_3
	elif _press_ctrl:
		move_speed = Constant.MOVE_SPEED_1
	else:
		move_speed = Constant.MOVE_SPEED_2


func _set_direction():
	if _press_up and _is_time_up_less():
		direction = Direction.NORTH
	elif _press_down and _is_time_down_less():
		direction = Direction.SOUTH
	elif _press_left and _is_time_left_less():
		direction = Direction.WEST
	elif _press_right and _is_time_right_less():
		direction = Direction.EAST
	elif _press_up:
		direction = Direction.NORTH
	elif _press_down:
		direction = Direction.SOUTH
	elif _press_left:
		direction = Direction.WEST
	elif _press_right:
		direction = Direction.EAST


func _set_velocity():
	if _press_up and direction == Direction.NORTH:
		velocity = Vector2(0, -move_speed)
	elif _press_down and direction == Direction.SOUTH:
		velocity = Vector2(0, move_speed)
	elif _press_left and direction == Direction.WEST:
		velocity = Vector2(-move_speed, 0)
	elif _press_right and direction == Direction.EAST:
		velocity = Vector2(move_speed, 0)
	else:
		velocity = Vector2.ZERO


func _reset():
	_press_up = false
	_press_down = false
	_press_left = false
	_press_right = false

	_time_up = 0
	_time_down = 0
	_time_left = 0
	_time_right = 0


func _is_time_right_less() -> bool:
	return [_time_up, _time_down, _time_left].any(func(it):   return _time_right <= it)


func _is_time_left_less() -> bool:
	return [_time_up, _time_down, _time_right].any(func(it):   return _time_left <= it)


func _is_time_down_less() -> bool:
	return [_time_up, _time_left, _time_right].any(func(it):   return _time_down <= it)


func _is_time_up_less() -> bool:
	return [_time_down, _time_left, _time_right].any(func(it):   return _time_up <= it)
