extends Timer

onready var label = $Label


func _ready():
	pass 

func time_left_to_end():
	var time_left = self.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _process(delta):
	label.text = "%02d:%02d" % time_left_to_end()

