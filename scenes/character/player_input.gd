extends Node


const _INPUT_DELAY_TIME: float = 0.2
const _TURN_DELAY_TIME: float = 0.1

var direction: int = Direction.SOUTH
var move_speed: int = Constant.MOVE_SPEED_0
var velocity: Vector2 = Vector2.ZERO

var _press_up: bool = false
var _press_down: bool = false
var _press_left: bool = false
var _press_right: bool = false

var _press_ctrl: bool = false
var _press_shift: bool = false

var _input_delay: float = 0
var _turn_delay: float = 0


func _ready():
	_input_delay = _INPUT_DELAY_TIME


func update(delta):
	if _input_delay > 0:
		_input_delay -= delta
	else:
		_process_input(delta)


func _process_input(delta):
	_process_key_input()
	_turn_delay = _get_turn_delay(delta)
	move_speed = _get_move_speed()
	direction = _get_direction()
	velocity = _get_velocity()


func _process_key_input():
	_press_up = Input.is_action_pressed("player_north")
	_press_down = Input.is_action_pressed("player_south")
	_press_left = Input.is_action_pressed("player_west")
	_press_right = Input.is_action_pressed("player_east")
	
	_press_ctrl = Input.is_action_pressed("player_crouch")
	_press_shift = Input.is_action_pressed("player_run")


func _get_turn_delay(delta) -> float:
	if _turn_delay <= 0 and velocity == Vector2.ZERO and _is_key_press_other_direction():
		return _TURN_DELAY_TIME
	elif !_are_move_keys_pressed():
		return 0
	else:
		return _turn_delay - delta


func _get_move_speed() -> int:
	if !_are_move_keys_pressed() or _are_opposite_keys_pressed() or _turn_delay > 0:
		return Constant.MOVE_SPEED_0
	elif _press_ctrl and _press_shift and Globals.is_in_debug_mode:
		return Constant.MOVE_SPEED_4
	elif _press_shift:
		return Constant.MOVE_SPEED_3
	elif _press_ctrl:
		return Constant.MOVE_SPEED_1
	else:
		return Constant.MOVE_SPEED_2


func _get_direction() -> int:
	if _are_opposite_keys_pressed():
		return direction
	elif _press_left:
		return Direction.WEST
	elif _press_right:
		return Direction.EAST
	elif _press_up:
		return Direction.NORTH
	elif _press_down:
		return Direction.SOUTH
	else:
		return direction


func _get_velocity() -> Vector2:
	if _are_move_keys_pressed() and !_are_opposite_keys_pressed() and _turn_delay <= 0:
		var input_direction: Vector2 = Input.get_vector("player_west", "player_east", "player_north", "player_south")
		var angle: float = deg_to_rad(round(rad_to_deg(input_direction.normalized().angle()) / 45.0) * 45.0)
		return Vector2(cos(angle), sin(angle)) * move_speed
	else:
		return Vector2.ZERO


func _are_move_keys_pressed() -> bool:
	return _press_up or _press_down or _press_left or _press_right


func _are_opposite_keys_pressed() -> bool:
	return (_press_up and _press_down) or (_press_left and _press_right)


func _is_key_press_other_direction() -> bool:
	return (_press_up and !(_press_left or _press_right) and direction != Direction.NORTH) \
		or (_press_down and !(_press_left or _press_right) and direction != Direction.SOUTH) \
		or (_press_left and !(_press_up or _press_down) and direction != Direction.WEST) \
		or (_press_right and !(_press_up or _press_down) and direction != Direction.EAST)

