extends Node2D

var failed : Label
var completed : Label
var task : Sprite

var sheep : Button
var clouds : Array = []

var scoreNode : Node
var timer : Timer
var score : int


func _ready():
	failed = $Bed/FailedLabel
	failed.visible = false
	completed = $Bed/CompletedLabel
	completed.visible = false
	task = $CountSheep
	task.visible = true
	
	timer = $Bed/SleepingTimer
	timer.connect("timeout", self, "_on_timer_timeout")
	
	sheep = $Bed/Sheep
	clouds = [$Bed/Cloud1, $Bed/Cloud2, $Bed/Cloud3, $Bed/Cloud4, $Bed/Cloud5,
	$Bed/Cloud7, $Bed/Cloud8, $Bed/Cloud9, $Bed/Cloud12, $Bed/Cloud13, $Bed/Cloud14,
	$Bed/Cloud15, $Bed/Cloud16, $Bed/Cloud17, $Bed/Cloud18, $Bed/Cloud10, $Bed/Cloud19,
	$Bed/Cloud20, $Bed/Cloud22, $Bed/Cloud23, $Bed/Cloud24, $Bed/Cloud11,]
	sheep.visible = false
	sheep.connect("pressed", self, "_on_sheep_pressed")
	for cloud in clouds:
		cloud.connect("pressed", self, "_on_cloud_pressed")
		cloud.visible = false
	
	scoreNode = get_node("Bed/countSheep")
	score = scoreNode.score
	
	start_sheep_task()

func start_sheep_task():
	task.visible = true
	sheep.visible = true
	for cloud in clouds:
		cloud.visible = true
	timer.wait_time = 30.0 
	timer.start()

func _on_sheep_pressed():
	scoreNode.update_score(scoreNode.score + 1)
	shuffle_buttons_positions()

func _on_cloud_pressed():
	scoreNode.update_score(scoreNode.score - 1)

func shuffle_buttons_positions():
	var buttonPositions = []
	var sheepPosition = sheep.rect_position
	buttonPositions.append(sheepPosition)
	for cloud in clouds:
		var cloudPosition = cloud.rect_position
		buttonPositions.append(cloudPosition)
	buttonPositions.shuffle()
	sheep.rect_position = buttonPositions[0]
	for i in range(clouds.size()):
		clouds[i].rect_position = buttonPositions[i + 1]


func _on_timer_timeout():
	if scoreNode.score >= 30:  
		on_task_completed()
	else:
		on_task_failed()


func on_task_completed():
	task.visible = false
	completed.visible = true
	sheep.visible = false
	for cloud in clouds:
		cloud.visible = false
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_next")
	add_child(timer)
	timer.start()

func on_task_failed():
	task.visible = false
	failed.visible = true
	sheep.visible = false
	for cloud in clouds:
		cloud.visible = false
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.connect("timeout", self, "_on_back")
	add_child(timer)
	timer.start()

func _on_next():
	get_tree().change_scene("res://scenes/Thoughts.tscn")

func _on_back():
	get_tree().change_scene("res://scenes/Level2.tscn")
