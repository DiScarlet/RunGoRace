extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dialogue_resource = load("res://dialogues/mother_1.dialogue")
	DialogueManager.show_dialogue_balloon(dialogue_resource, "sky_meeting")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
