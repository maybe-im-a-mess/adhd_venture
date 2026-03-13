extends Area2D


var typingTaskTimer : Timer
var requiredText : String = "example"

func _ready():
	typingTaskTimer = $Timer
	typingTaskTimer.connect("timeout", self, "_on_typing_task_timeout")

func _on_typing_task_timeout():
	print("Typing task failed!")

func start_typing_task():
	typingTaskTimer.start()
	$TextInput.text = ""

func _input(event):
	if event is InputEventKey and event.scancode == KEY_ENTER:
		check_typing_task()

func check_typing_task():
	var enteredText : String = $TextInput.text.strip_edges()
	if enteredText == requiredText:
		on_task_completed()
	else:
		on_task_failed()

func on_task_completed():
	typingTaskTimer.stop()
	print("Typing task completed!")

func on_task_failed():
	typingTaskTimer.stop()
	print("Typing task failed!")
