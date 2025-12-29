extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_entered)


func _on_player_entered(body):
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/dialogueHoboKnight.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "defector_start")
