extends Node2D

var goodFolder: Area2D
var badFolder: Area2D
var thoughts : Array = []
var currentThoughtIndex: int = 0

var goods : Array = []
var bads : Array = []

var coffee : Sprite
var ThoughtTaskLabel : Label
var failed : Label
var completed : Label
var coffeeTimer : Timer

var isDragging : bool = false


func _ready():
	
	ThoughtTaskLabel = $Task/TaskLabel
	ThoughtTaskLabel.visible = false
	
	failed = $Bed/FailedLabel
	failed.visible = false
	completed = $Bed/CompletedLabel
	completed.visible = false
	
	goodFolder = $Bed/GoodFolder/Area2D
	badFolder = $Bed/BadFolder/Area2D
	goodFolder.connect("area_entered", self, "_on_good_area_entered")
	badFolder.connect("area_entered", self, "_on_bad_area_entered")
	
	goods = ["Good1", "Good2", "Good3", "Good4", "Good5", "Good6", "Good7", "Good8", "Good9"]
	bads = ["Bad1", "Bad2", "Bad3", "Bad4", "Bad5", "Bad6", "Bad7", "Bad8", "Bad9"]

	thoughts = [$Bed/Bad1, $Bed/Bad2, $Bed/Bad3, $Bed/Bad4, $Bed/Bad5, 
	$Bed/Bad6, $Bed/Bad7, $Bed/Bad8, $Bed/Bad9, $Bed/Good1, $Bed/Good2, 
	$Bed/Good3, $Bed/Good4, $Bed/Good5, $Bed/Good6, $Bed/Good7, $Bed/Good8, $Bed/Good9]
	shuffle(thoughts)
	for thought in thoughts:
		thought.visible = false

	start_thoughts_task()

func shuffle(arr):
	for i in range(arr.size() - 1, 0, -1):
		var j = randi() % (i + 1)

		var temp = arr[i]
		arr[i] = arr[j]
		arr[j] = temp

func start_thoughts_task():
	ThoughtTaskLabel.visible = true
	load_thought()

func _on_good_area_entered(area):
	var currentName = str(thoughts[currentThoughtIndex].get_name())
	if currentName in goods:
		currentThoughtIndex += 1
		load_thought()
	else:
		on_task_failed()
		
func _on_bad_area_entered(area):
	var currentName = str(thoughts[currentThoughtIndex].get_name())
	if currentName in bads:
		currentThoughtIndex += 1
		load_thought()
	else:
		on_task_failed()

func load_thought():
	if currentThoughtIndex == 17:
		on_task_completed()
	else:
		for thought in thoughts:
			thought.visible = false
		if currentThoughtIndex < thoughts.size():
			thoughts[currentThoughtIndex].visible = true
			if currentThoughtIndex == thoughts.size() - 1:
				shuffle(thoughts)

func on_task_completed():
	$Task.visible = false
	$Bed/GoodFolder.visible = false
	$Bed/BadFolder.visible = false
	completed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()

func on_task_failed():
	$Task.visible = false
	$Bed/GoodFolder.visible = false
	$Bed/BadFolder.visible = false
	failed.visible = true
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()
	
func _on_redirect_timeout():
	get_tree().change_scene("res://scenes/Level2.tscn")
