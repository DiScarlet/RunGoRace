extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.dialogue_mother_1.connect(_on_mother_1)	
	
func _on_mother_1():
	var dialogue_resource = load("res://dialogues/mother_1.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "sky_meeting")
