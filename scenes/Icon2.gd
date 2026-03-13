extends Control

var is_dragging = false

func _on_mouse_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_mouse_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			is_dragging = true
			grab_focus()
		elif event.release and is_dragging:
			is_dragging = false
			release_focus()

func _process(delta):
	if is_dragging:
		rect_position.x += Input.get_mouse_speed().x
		rect_position.y += Input.get_mouse_speed().y
