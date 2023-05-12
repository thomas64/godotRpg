extends ConfirmationDialog


@export_multiline var centered_text: String = ""


func _ready():
	$Label.text = centered_text


func _input(event):
	if event is InputEventMouse:
		get_viewport().set_input_as_handled()
		return

	if event.is_action_pressed("ui_focus_prev") or event.is_action_pressed("ui_focus_next"):
		get_viewport().set_input_as_handled()
		return

	if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		if (event.is_action_pressed("ui_left") and get_ok_button().has_focus()) \
		or (event.is_action_pressed("ui_right") and get_cancel_button().has_focus()):
			AudioManager.play_sfx("menu_error")
		else:
			AudioManager.play_sfx("menu_cursor")


func _on_visibility_changed():
	if visible:
		get_cancel_button().grab_focus()


func _on_canceled():
	AudioManager.play_sfx("menu_back")

