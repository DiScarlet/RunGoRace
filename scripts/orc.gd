extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var dialogue_triggered = false

func _ready():
	$Area2D.body_entered.connect(_on_player_entered)
	GameState.ork_start_attack.connect(_on_start_attack)
	GameState.ork_attack.connect(_on_continue_attack)
	GameState.ork_back_default.connect(_on_default)
	
func _on_default():
	animated_sprite.play("default")
	
func _on_player_entered(body):
	if body is CharacterBody2D and not dialogue_triggered:
		dialogue_triggered = true
		var dialogue_resource = load("res://dialogues/dialogueOrk.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "ork_start")
		
func _on_start_attack():
	animated_sprite.play("start_attack")
	
func _on_continue_attack():
	print("Ork continued")
	animated_sprite.play("attack_continue")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
