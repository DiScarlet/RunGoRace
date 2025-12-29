extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.body_entered.connect(_on_player_entered)
	GameState.krab_attack.connect(_on_attack)
	GameState.krab_death.connect(_on_death)
	GameState.krab_hurt.connect(_on_hurt)

func  _on_player_entered(body):
	print("entered kr")
	if body is CharacterBody2D:
		var dialogue_resource = load("res://dialogues/dialogueKrab.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")

func _on_attack():
	print("attacked by kr")
	animated_sprite.play("attack")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
func _on_death():
	print("dead kr")
	animated_sprite.play("death")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
func _on_hurt():
	print("hurt kr")
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
