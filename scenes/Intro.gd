extends Node2D

var background : Sprite
var introduction : Label
var start : Button
var timer : Timer


func _ready():
	Sound.play_sound()
	start = $StartButton
	start.connect("pressed", self, "_on_start_pressed")
	start.visible = false
	
	timer = Timer.new()
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 10.0
	timer.one_shot = true
	add_child(timer)
	timer.start()


func _on_timer_timeout():
	start.visible = true

func _on_start_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
