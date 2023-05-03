extends Control


func _on_visibility_changed():
	if visible:
		$CanvasLayer.show()
	else:
		$CanvasLayer.hide()


func _input(event):
	if event.is_action_pressed("pause"):
		accept_event()
		hide()
		get_tree().paused = false

