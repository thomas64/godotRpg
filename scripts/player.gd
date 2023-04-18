extends CharacterBody2D


func _physics_process(delta):
	$player_input.update(delta)
	var direction = $player_input.direction
	var move_speed = $player_input.move_speed
	velocity = $player_input.velocity

	move_and_slide()
	$AnimatedSprite2D.update(direction, move_speed)
