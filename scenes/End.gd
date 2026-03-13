extends Node2D


var link : LinkButton
var timer : Timer


func _ready():
	link = $LinkButton
	link.visible = false
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 9.0 
	timer.connect("timeout", self, "_on_timer1_timeout")
	add_child(timer)
	
	timer.start()

func _on_timer1_timeout():
	link.visible = true


func _on_LinkButton_pressed():
	OS.shell_open("https://www.nimh.nih.gov/health/statistics/attention-deficit-hyperactivity-disorder-adhd")
