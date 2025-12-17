extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
var dialogue_triggered: bool = false
var is_attacking: bool = false # Protects the attack animation

func _ready():
	# Connect to your proximity area
	$Area2D.body_entered.connect(_on_player_entered)
	GameState.player_attack_villager.connect(_on_got_attacked_command_received)
	GameState.request_attack.connect(_on_attack_command_received)

func _on_got_attacked_command_received():
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	print("hurt vill")
	
func _on_player_entered(body):
	if body is CharacterBody2D and not dialogue_triggered:
		dialogue_triggered = true
		var dialogue_resource = load("res://dialogues/dialogueVillager1.dialogue")
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")

func _on_attack_command_received():
	# 1. Stop movement animations
	is_attacking = true
	# 2. Play the attack
	animated_sprite.play("attack1")
	# 3. Wait for it to finish
	await animated_sprite.animation_finished
	# 4. Allow idle animations again
	is_attacking = false

func _physics_process(_delta: float) -> void:
	# If we are in the attack state, do NOT play "default"
	if is_attacking:
		return
	
	animated_sprite.play("default")
