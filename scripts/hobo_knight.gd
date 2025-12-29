extends Node2D

@onready var animated_sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_entered)
	GameState.defector_attack.connect(_on_attack_command_received)
	GameState.defector_hurt.connect(_on_hurt)

func _on_attack_command_received():
	animated_sprite.play("attack")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	print("hurt vill")

func _on_player_entered(body):
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/dialogueHoboKnight.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "defector_start")

func _on_hurt():
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
