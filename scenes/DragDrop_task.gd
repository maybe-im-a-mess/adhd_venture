extends Node2D

var coffeeVisible = false
var coffeeRinging = false

var animalFolder: Area2D
var natureFolder: Area2D
var images : Array = []
var currentImageIndex: int = 0

var animals : Array = []
var natures : Array = []

var coffee : Sprite
var DragDropTaskLabel : Label
var failed : Label
var completed : Label
var coffeeTimer : Timer

var isDragging : bool = false

var alex : Sprite
var intro : Label
var bubble : Sprite

var currentName


func _ready():
	alex = $alex
	intro = $drinking
	bubble = $bubble
	alex.visible = false
	intro.visible = false
	bubble.visible = false
	coffee = $Coffee
	coffee.visible = false
	$TakeBreakButton.visible = false
	$TakeBreakButton.connect("pressed", self, "_on_take_brake_pressed")
	
	DragDropTaskLabel = $Screen/DragDropTaskLabel
	DragDropTaskLabel.visible = false
	
	failed = $Screen/FailedLabel
	failed.visible = false
	completed = $Screen/CompletedLabel
	completed.visible = false
	
	# Initialize the timer
	coffeeTimer = Timer.new()
	coffeeTimer.wait_time = 10.0
	coffeeTimer.one_shot = false
	coffeeTimer.connect("timeout", self, "_on_coffee_timer_timeout")
	add_child(coffeeTimer)
	
	animalFolder = $Screen/AnimalFolder/Area2D
	natureFolder = $Screen/NatureFolder/Area2D
	animalFolder.connect("area_entered", self, "_on_animal_area_entered")
	natureFolder.connect("area_entered", self, "_on_nature_area_entered")
	
	animals = ["Dog", "Cat", "Bird", "Elephant", "Tiger", "Horse", "Zebra", "Otter"]
	natures = ["Flower", "Tree", "Stone", "River", "Mountain", "Cloud", "Moon", "Stars"]

	images = [$Screen/Dog, $Screen/Cat, $Screen/Bird, $Screen/Elephant, 
	$Screen/Tiger, $Screen/Horse, $Screen/Zebra, $Screen/Otter,
	$Screen/Flower, $Screen/Tree, $Screen/Stone, $Screen/River, $Screen/Mountain,
	$Screen/Cloud, $Screen/Moon, $Screen/Stars]
	shuffle(images)
	for image in images:
		image.visible = false

	
	if !coffeeRinging:
		DragDropTaskLabel.visible = true
		start_dragdrop_task()
		coffeeTimer.start()

func shuffle(arr):
	for i in range(arr.size() - 1, 0, -1):
		var j = randi() % (i + 1)

		var temp = arr[i]
		arr[i] = arr[j]
		arr[j] = temp

func start_dragdrop_task():
	load_image()

func _on_animal_area_entered(area):
	if !coffeeRinging:
		if currentName in animals:
			currentImageIndex += 1
			load_image()
		else:
			on_task_failed()
		
func _on_nature_area_entered(area):
	if !coffeeRinging:
		if currentName in natures:
			currentImageIndex += 1
			load_image()
		else:
			on_task_failed()

func load_image():
	if currentImageIndex == 16:
		on_task_completed()
	else:
		currentName = str(images[currentImageIndex].get_name())
		if !coffeeRinging:
			for image in images:
				image.visible = false
			if currentImageIndex < images.size():
				images[currentImageIndex].visible = true
				if currentImageIndex == images.size() - 1:
					shuffle(images)

	
func _on_coffee_timer_timeout():
	coffee.visible = true
	$TakeBreakButton.visible = true
	alex.visible = true
	bubble.visible = true
	intro.visible = true
	DragDropTaskLabel.visible = false
	coffeeRinging = true
	for image in images:
		image.visible = false
	$Screen/AnimalFolder.visible = false
	$Screen/NatureFolder.visible = false

func _on_take_brake_pressed():
	if coffeeRinging:
		coffeeRinging = false
		coffee.visible = false
		alex.visible = false
		bubble.visible = false
		intro.visible = false
		$TakeBreakButton.visible = false
		DragDropTaskLabel.visible = true
		images[currentImageIndex].visible = true
		$Screen/AnimalFolder.visible = true
		$Screen/NatureFolder.visible = true
		coffeeTimer.start()

func on_task_completed():
	DragDropTaskLabel.visible = false
	completed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()

func on_task_failed():
	DragDropTaskLabel.visible = false
	failed.visible = true
	var timer = Timer.new()
	timer.wait_time = 1.8
	timer.one_shot = true
	timer.connect("timeout", self, "_on_redirect_timeout")
	add_child(timer)
	timer.start()
	
func _on_redirect_timeout():
	get_tree().change_scene("res://scenes/Level1.tscn")
