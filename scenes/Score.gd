extends Label
var score = 0


func _ready():
	pass 


func _process(delta):
	self.text = str("Count: ", score, "/20")


func update_score(new_score):
	score = new_score
