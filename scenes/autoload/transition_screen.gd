extends CanvasLayer


func fade_to_black():
	$AnimationPlayer.play("fade_to_black")


func fade_to_normal():
	$AnimationPlayer.play("fade_to_normal")


func _on_animation_player_animation_started(anim_name):
	if anim_name == "fade_to_black":
		get_tree().root.set_disable_input(true)


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_to_normal":
		await get_tree().create_timer(Constant.FADE_TIME).timeout
		get_tree().root.set_disable_input(false)

