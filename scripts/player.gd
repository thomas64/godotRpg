extends CharacterBody2D


var direction: int
var move_speed: int


func _physics_process(delta):
	_update_physics(delta)
	_set_collision_mask()
	move_and_slide()
	$move_animation.update()
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
	var tile_map: TileMap = get_parent().get_children().front() as TileMap
	var underground = tile_map.get_underground_for(_get_offset_feet_position())
	$entity_footsteps.play_sound(underground)


func _get_offset_feet_position() -> Vector2:
	if velocity == Vector2.ZERO:
		return position
	else:
		match direction:
			Direction.NORTH: return Vector2(position.x, position.y - (move_speed / 10))
			Direction.SOUTH: return Vector2(position.x, position.y + (move_speed / 10))
			Direction.WEST: return Vector2(position.x - (move_speed / 10), position.y)
			Direction.EAST: return Vector2(position.x + (move_speed / 10), position.y)
			_: return Vector2.ZERO

