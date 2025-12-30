extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_entered)
	GameState.archivist_hurt.connect(_on_hurt)
	GameState.archivist_death.connect(_on_death)

func _on_player_entered(body):
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/dialogueArchivist.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "archivist_start")
		
func _on_hurt():
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
func _on_death():
	animated_sprite.play("death")
	await animated_sprite.animation_finished
