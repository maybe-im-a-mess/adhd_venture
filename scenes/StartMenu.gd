extends Node2D

var background : Sprite
var gameName : AnimatedSprite
var start : Button


func _ready():
	start = $StartButton
	start.connect("pressed", self, "_on_start_pressed")

func _on_start_pressed():
	get_tree().change_scene("res://scenes/Intro.tscn")
