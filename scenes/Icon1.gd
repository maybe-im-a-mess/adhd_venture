extends Control

var is_dragging = false
var offset = Vector2()

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed and get_rect().has_point(event.position):
				is_dragging = true
				offset = event.position - rect_position
				grab_focus()

			elif event.release and is_dragging:
				is_dragging = false
				release_focus()

	elif event is InputEventMouseMotion and is_dragging:
		rect_position = event.position - offset
