extends Node2D

var in_dialogue = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Healer entered")
	if body is CharacterBody2D and not in_dialogue:
		in_dialogue = true
		var dialogue_resource = load("res://dialogues/dialogueHealer.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "samurai_start")
