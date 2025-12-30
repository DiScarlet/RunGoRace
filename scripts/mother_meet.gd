extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.dialogue_mother_1.connect(_on_mother_1)	
	GameState.dialogue_mother_2.connect(_on_mother_2)	
	GameState.dialogue_mother_3.connect(_on_mother_3)	
	
func _on_mother_1():
	var dialogue_resource = load("res://dialogues/mother_1.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "sky_meeting")
	
func _on_mother_2():
	var dialogue_resource = load("res://dialogues/mother_2.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "mother_second_meeting_start")
	
func _on_mother_3():
	var dialogue_resource = load("res://dialogues/mother_3.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "mother_return")
