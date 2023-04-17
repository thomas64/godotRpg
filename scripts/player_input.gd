extends Node


var direction: int = Direction.SOUTH
var move_speed: int = Constant.MOVE_SPEED_0
var velocity: Vector2 = Vector2.ZERO

var _press_up: bool = false
var _press_down: bool = false
var _press_left: bool = false
var _press_right: bool = false

var _press_ctrl: bool = false
var _press_shift: bool = false


func update():
	_process_key_input()
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


func _set_move_speed():
	if !_press_up and !_press_down and !_press_left and !_press_right:
		move_speed = Constant.MOVE_SPEED_0
	elif _press_up and _press_down:
		move_speed = Constant.MOVE_SPEED_0
	elif _press_left and _press_right:
		move_speed = Constant.MOVE_SPEED_0
	elif _press_ctrl and _press_shift:
		move_speed = Constant.MOVE_SPEED_4
	elif _press_shift:
		move_speed = Constant.MOVE_SPEED_3
	elif _press_ctrl:
		move_speed = Constant.MOVE_SPEED_1
	else:
		move_speed = Constant.MOVE_SPEED_2


func _set_direction():
	if _press_up and _press_down:
		direction = Direction.SOUTH
	elif _press_left and _press_right:
		direction = Direction.SOUTH
	elif _press_left:
		direction = Direction.WEST
	elif _press_right:
		direction = Direction.EAST
	elif _press_up:
		direction = Direction.NORTH
	elif _press_down:
		direction = Direction.SOUTH


func _set_velocity():
	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * move_speed

