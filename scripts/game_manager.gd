extends Node

var score = 0

@onready var coins_hint = $Coins_Hint

func add_point():
	score += 1
	coins_hint.text = "You collected " + str(score) + " coints"
