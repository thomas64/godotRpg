extends Node


var _sounds: Dictionary
var _move_speed: int

var _step_delay: float = 0


func _ready():
	_sounds = { "carpet": $sound_pool_carpet,
				"grass": $sound_pool_grass,
				"sand": $sound_pool_sand,
				"stone": $sound_pool_stone,
				"water": $sound_pool_water,
				"wood": $sound_pool_wood }


func _physics_process(delta):
	_step_delay -= delta
	_move_speed = get_parent().move_speed


func play_sound(underground: String):
	if _move_speed in [Constant.MOVE_SPEED_2, Constant.MOVE_SPEED_3]:
		if _step_delay <= 0:
			_step_delay = _get_frame_time()
			_sounds[underground].play_sound()
	else:
		_step_delay = 0


func _get_frame_time() -> float:
	match _move_speed:
		Constant.MOVE_SPEED_0: return Constant.NO_FRAMES
		Constant.MOVE_SPEED_1: return Constant.SLOW_FRAMES
		Constant.MOVE_SPEED_2: return Constant.NORMAL_FRAMES
		Constant.MOVE_SPEED_3: return Constant.FAST_FRAMES
		Constant.MOVE_SPEED_4: return Constant.NO_FRAMES
		_:						 return Constant.NO_FRAMES

