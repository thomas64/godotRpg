extends CanvasLayer


func _process(_delta):
	if Globals.is_in_debug_mode and not visible:
		show()
	elif not Globals.is_in_debug_mode and visible:
		hide()

	if visible:
		$Label.set_text("FPS %d" % Engine.get_frames_per_second())

