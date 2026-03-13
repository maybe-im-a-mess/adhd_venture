extends Node2D

var background : Sprite
var computerArea : Area2D
var bedArea : Area2D
var alex : Sprite
var bubble : Sprite
var intro : Label
var timer1 : Timer
var timer2 : Timer
var exit : Button

func _ready():
	exit = $exit
	exit.connect("pressed", self, "_on_exit_pressed")
	alex = $alex
	bubble = $bubble
	intro = $Introduction
	alex.visible = false
	bubble.visible = false
	intro.visible = false
	background = $Background 
	computerArea = $ComputerArea  
	computerArea.connect("input_event", self, "_on_computer_area_input_event")
	bedArea = $BedArea
	bedArea.connect("input_event", self, "_on_bed_area_input_event")
	timer1 = Timer.new()
	timer1.one_shot = true
	timer1.wait_time = 0.1 
	timer1.connect("timeout", self, "_on_timer1_timeout")
	add_child(timer1)
	
	timer2 = Timer.new()
	timer2.one_shot = true
	timer2.wait_time = 0.2
	timer2.connect("timeout", self, "_on_timer2_timeout")
	add_child(timer2)
	
	timer1.start()


func _on_timer1_timeout():
	alex.visible = true
	timer2.start()

func _on_timer2_timeout():
	bubble.visible = true
	intro.visible = true


func _on_computer_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and shape_idx == 0:
		start_first_level()

func _on_bed_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and shape_idx == 0:
		start_second_level()

func start_first_level():
	get_tree().change_scene("res://scenes/Level1.tscn")

func start_second_level():
	get_tree().change_scene("res://scenes/Level2.tscn")

func _on_exit_pressed():
	get_tree().change_scene("res://scenes/End.tscn")
