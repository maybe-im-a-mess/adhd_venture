extends Node

func _ready():
	_find_buttons(get_tree().get_root())

func _find_buttons(node):
	if node is Button:
		print("Found button:", node)
		node.connect("pressed", self, "_on_button_pressed")
	
	for child in node.get_children():
		_find_buttons(child)

func _on_button_pressed():
	$ButtonClick.play()

func _process(delta):
	_find_buttons(get_tree().get_root())
	if $BackgroundMusic.playing == false:
		$BackgroundMusic.play()

func play_sound():
	$BackgroundMusic.play()
