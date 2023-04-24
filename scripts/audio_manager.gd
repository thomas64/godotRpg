extends Node


func play(track_names: Array):
	for track in get_children():
		if track.name not in track_names:
			fade(track)

	for track_name in track_names:
		var track = get_node(track_name)
		if !track.playing:
			track.play()


func fade(track: AudioStreamPlayer):
	var tween = create_tween()
	var org_db = track.volume_db
	tween.tween_property(track, "volume_db", -80, 0.5)
	track.stop()
	tween.tween_property(track, "volume_db", org_db, 0)

