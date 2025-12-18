extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

var dialogue_triggered = false
func _ready():
	$Area2D.body_entered.connect(_on_player_entered)
	GameState.crescent_captain_attack.connect(_on_attack_command_received)
	GameState.crescent_captain_die.connect(_on_die)
	
func _on_die():
	animated_sprite.play("die")
	
func _on_attack_command_received():
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	animated_sprite.play("attack1")
	await animated_sprite.animation_finished
	animated_sprite.play("attack2")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
	
func _on_player_entered(body):
	if body is CharacterBody2D and not dialogue_triggered:
		dialogue_triggered = true
		var dialogue_resource = load("res://dialogues/final_boss_dialogue.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "crescent_start")
