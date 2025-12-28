extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Healer entered")
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/dialogueHealer.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "samurai_start")
