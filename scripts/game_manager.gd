extends Node

signal event_finished
var last_event_success: bool = false

var score = 0

@onready var coins_hint = $Coins_Hint

func add_point():
	score += 1
	coins_hint.text = "You collected " + str(score) + " coints"
	
func start_click_event():
	var qte_scene = load("res://LetterClickGame.tscn").instantiate()
	get_tree().root.add_child(qte_scene)
	qte_scene.qte_completed.connect(_on_qte_completed)

func _on_qte_completed(success: bool):
	last_event_success = success
	event_finished.emit() # This tells Dialogue Manager to resume
