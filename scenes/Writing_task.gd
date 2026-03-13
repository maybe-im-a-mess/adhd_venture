extends Node2D

var phoneVisible = false
var phoneRinging = false
var typingTaskActive = false
var keyPhrases : Array = [
	"project",
	"john",
	"is",
	"was",
	"great",
	"good",
	"satisfied"
]
var background : Sprite
var computer : Sprite
var screen : Control
var phone : Sprite
var writingTaskLabel : Label
var failed : Label
var completed : Label
var phoneTimer : Timer
var alex : Sprite
var intro : Label
var bubble : Sprite

func _ready():
	alex = $alex
	intro = $calling
	bubble = $bubble
	alex.visible = false
	intro.visible = false
	bubble.visible = false
	phone = $Phone
	phone.visible = false
	$AnswerPhoneButton.visible = false
	$AnswerPhoneButton.connect("pressed", self, "_on_answer_phone_pressed")
	$Screen/TextInput.connect("text_entered", self, "_on_text_input_entered")
	$Screen/TextInput.visible = false
	
	writingTaskLabel = $Screen/writingTaskLabel
	writingTaskLabel.visible = false
	
	failed = $Screen/FailedLabel
	failed.visible = false
	completed = $Screen/CompletedLabel
	completed.visible = false
	
	phoneTimer = Timer.new()
	phoneTimer.wait_time = 8.0
	phoneTimer.one_shot = false
	phoneTimer.connect("timeout", self, "_on_phone_timer_timeout")
	add_child(phoneTimer)
	
	if !phoneRinging:
		writingTaskLabel.visible = true
		start_typing_task()
		phoneTimer.start()


func start_typing_task():
	typingTaskActive = true
	writingTaskLabel.visible = true
	$Screen/TextInput.visible = true

func _on_text_input_entered(new_text):
	if typingTaskActive and !phoneRinging:
		var textInput = new_text.to_lower()
		var containsWord = false
		for phrase in keyPhrases:
			if textInput.find(phrase) != -1:
				containsWord = true
				break

		if containsWord:
			on_task_completed()
		else:
			on_task_failed()

		typingTaskActive = false
		$Screen/TextInput.visible = false

func _on_phone_timer_timeout():
	phone.visible = true
	$AnswerPhoneButton.visible = true
	alex.visible = true
	bubble.visible = true
	intro.visible = true
	$Screen/TextInput.visible = false
	writingTaskLabel.visible = false
	phoneRinging = true

func _on_answer_phone_pressed():
	if phoneRinging:
		phoneRinging = false
		phone.visible = false
		alex.visible = false
		bubble.visible = false
		intro.visible = false
		$AnswerPhoneButton.visible = false
		$Screen/TextInput.visible = true
		writingTaskLabel.visible = true
		phoneTimer.start()


func on_task_completed():
	writingTaskLabel.visible = false
	completed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()

func on_task_failed():
	writingTaskLabel.visible = false
	failed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()
	
func _on_redirect_timeout():
	get_tree().change_scene("res://scenes/Level1.tscn")
