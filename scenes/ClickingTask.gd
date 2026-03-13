extends Node2D

var background : Sprite
var computer : Sprite
var screen : Control
var clickingTaskLabel : Label
var failed : Label
var completed : Label

var scoreNode : Node

var centralTask : Button
var distractions : Array = []
var timer : Timer
var score : int


func _ready():
	clickingTaskLabel = $Screen/clickingTaskLabel
	clickingTaskLabel.visible = false
	failed = $Screen/FailedLabel
	failed.visible = false
	completed = $Screen/CompletedLabel
	completed.visible = false
	
	centralTask = $Screen/Work
	distractions = [$Screen/Eat, $Screen/Shopping, $Screen/Cat, $Screen/Break,
	$Screen/Chat, $Screen/Window, $Screen/Game, $Screen/Walk, $Screen/Flowers,
	$Screen/Sleep]
	centralTask.visible = false
	for distraction in distractions:
		distraction.connect("pressed", self, "_on_distraction_pressed")
		distraction.visible = false
		
	centralTask.connect("pressed", self, "_on_work_pressed")
	
	timer = $Screen/WorkingTimer
	timer.connect("timeout", self, "_on_timer_timeout")
	
	scoreNode = get_node("Screen/Score")
	score = scoreNode.score
	
	start_clicking_task()
	
	
func start_clicking_task():
	
	clickingTaskLabel.visible = true
	centralTask.visible = true
	for distraction in distractions:
		distraction.visible = true
	timer.wait_time = 30.0 
	timer.start()


func _on_work_pressed():
	scoreNode.update_score(scoreNode.score + 1)
	shuffle_buttons_positions()

func _on_distraction_pressed():
	scoreNode.update_score(scoreNode.score - 1)

func shuffle_buttons_positions():
	var buttonPositions = []
	var centralTaskPosition = centralTask.rect_position
	buttonPositions.append(centralTaskPosition)
	for distraction in distractions:
		var distractionPosition = distraction.rect_position
		buttonPositions.append(distractionPosition)
	buttonPositions.shuffle()
	centralTask.rect_position = buttonPositions[0]
	for i in range(distractions.size()):
		distractions[i].rect_position = buttonPositions[i + 1]


func _on_timer_timeout():
	if scoreNode.score >= 20:  
		on_task_completed()
	else:
		on_task_failed()

func on_task_completed():
	clickingTaskLabel.visible = false
	centralTask.visible = false
	for distraction in distractions:
		distraction.visible = false
	completed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()

func on_task_failed():
	clickingTaskLabel.visible = false
	centralTask.visible = false
	for distraction in distractions:
		distraction.visible = false
	failed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()
	
func _on_redirect_timeout():
	get_tree().change_scene("res://scenes/Level1.tscn")

