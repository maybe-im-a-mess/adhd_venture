extends Node2D

var background : Sprite
var computer : Sprite
var screen : Control
var writing : TextureButton
var dragdrop : TextureButton
var click : TextureButton
var exit : Button
var alex : Sprite
var intro : Label
var timer1 : Timer
var timer2 : Timer

func _ready():
	alex = $alex
	intro = $Label
	alex.visible = false
	intro.visible = false
	writing = $Screen/Writing
	writing.connect("pressed", self, "_on_writing_pressed")
	dragdrop = $Screen/DragDrop
	dragdrop.connect("pressed", self, "_on_dragdrop_pressed")
	click = $Screen/Click
	click.connect("pressed", self, "_on_click_pressed")
	exit = $Screen/Exit
	exit.connect("pressed", self, "_on_exit_pressed")
	timer1 = Timer.new()
	timer1.one_shot = true
	timer1.wait_time = 0.4 # Adjust the delay as needed
	timer1.connect("timeout", self, "_on_timer1_timeout")
	add_child(timer1)
	
	timer1.start()

func _on_timer1_timeout():
	alex.visible = true
	intro.visible = true


# Writing task logic
func _on_writing_pressed():
	get_tree().change_scene("res://scenes/Writing_task.tscn")

# Drag and Drop task logic
func _on_dragdrop_pressed():
	get_tree().change_scene("res://scenes/DragDrop_task.tscn")

# Clicking task logic
func _on_click_pressed():
	get_tree().change_scene("res://scenes/ClickingTask.tscn")

func _on_exit_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	
