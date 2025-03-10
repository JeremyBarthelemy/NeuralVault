extends Node3D

var score : int = 0
@export var score_text : Label

func _ready():
	$BackgroundMusic.play()
	
func increase_score(amount):
	score += amount
	score_text.text = str("Score: ", score)
