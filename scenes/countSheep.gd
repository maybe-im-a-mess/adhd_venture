extends Label
var score = 0


func _process(delta):
	self.text = str("Sheep: ", score, "/30")


func update_score(new_score):
	score = new_score
