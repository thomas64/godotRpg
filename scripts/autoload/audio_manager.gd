extends Node


func play_sfx(track_name: String):
	get_node(track_name).play()


func play_one(track_name: String):
	play_multiple([track_name])


func play_multiple(track_names: Array):
	for track_name in track_names:
		var track = get_node(track_name)
		if !track.playing:
			track.play()


func fade_all_but(track_names: Array):
	for track in get_children():
		if track.name not in track_names:
			_fade(track, create_tween())


func fade_and_run(track_name: String, run_after_fade: Callable):
	var track = get_node(track_name)
	var tween = create_tween()
	_fade(track, tween)
	tween.tween_callback(run_after_fade)


func _fade(track: AudioStreamPlayer, tween):
	var org_db = track.volume_db
	tween.tween_property(track, "volume_db", -80, 1)
	tween.tween_property(track, "playing", false, 0)
	tween.tween_property(track, "volume_db", org_db, 0)

