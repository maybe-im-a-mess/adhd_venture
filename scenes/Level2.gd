extends Node2D

var background : Sprite
var bed : Sprite
var task : Sprite
var pillow : Area2D
var exit : Button
var failed : Label
var completed : Label

func _ready():
	task = $Task
	task.visible = true
	pillow = $Pillow
	pillow.connect("input_event", self, "_on_pillow_input_event")
	exit = $Bed/Exit
	exit.connect("pressed", self, "_on_exit_pressed")

func _on_pillow_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and shape_idx == 0:
		get_tree().change_scene("res://scenes/CountingSheep.tscn")

func _on_exit_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	
