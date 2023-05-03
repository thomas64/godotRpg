extends Node


func with_fade_to(path: String):
	TransitionScreen.fade_to_black()
	await get_tree().create_timer(Constant.FADE_TIME).timeout
	get_tree().change_scene_to_file(path)
	TransitionScreen.fade_to_normal()

