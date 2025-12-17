extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var dialogue_triggered: bool = false

func _ready():
	# Connect to your proximity area
	$Area2D.body_entered.connect(_on_player_entered)
	
func _on_player_entered(body):
	if body is CharacterBody2D and not dialogue_triggered:
		dialogue_triggered = true
		var dialogue_resource = load("res://dialogues/dialogueMonk.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "act2_start")
