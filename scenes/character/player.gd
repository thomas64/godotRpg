extends CharacterBody2D


var direction: int
var move_speed: int

@export var _feet_offset: float


func _ready():
	_possible_set_previous_direction()
	_possible_spawn_player()
	TempStorage.clear_params()


func stop_animation():
	$character_sprite_animation.stop()


func _physics_process(delta):
	_update_physics(delta)
	_set_collision_mask()
	move_and_slide()
	$character_sprite_animation.animate()
	_play_footsteps()


func _update_physics(delta):
	$player_input.update(delta)
	direction = $player_input.direction
	move_speed = $player_input.move_speed
	velocity = $player_input.velocity


func _set_collision_mask():
	if move_speed == Constant.MOVE_SPEED_4:
		collision_mask = 0
	else:
		collision_mask = 1


func _play_footsteps():
	var underground = $%TileMap.get_underground_for(_get_offset_feet_position())
	$character_footsteps_audio.play_sound(underground)


func _get_offset_feet_position() -> Vector2:
	if velocity == Vector2.ZERO:
		return position
	else:
		match direction:
			Direction.NORTH: return Vector2(position.x, position.y - (move_speed / _feet_offset))
			Direction.SOUTH: return Vector2(position.x, position.y + (move_speed / _feet_offset))
			Direction.WEST: return Vector2(position.x - (move_speed / _feet_offset), position.y)
			Direction.EAST: return Vector2(position.x + (move_speed / _feet_offset), position.y)
			_: 				return Vector2.ZERO


func _possible_set_previous_direction():
	if TempStorage.has_param("direction"):
		$player_input.direction = TempStorage.get_param("direction")


func _possible_spawn_player():
	if TempStorage.has_param("spawn_point"):
		position = get_parent().get_node(TempStorage.get_param("spawn_point")).position
		$Camera2D.reset_smoothing()

