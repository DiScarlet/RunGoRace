extends Area2D

@onready var timer: Timer = $Timer
@export var killzone_id: String = "Unknown"

var player_ref: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	player_ref = body as CharacterBody2D
	if player_ref == null:
		return

	Engine.time_scale = 0.5

	# Disable collisions safely
	var collision := player_ref.get_node_or_null("CollisionShape2D")
	if collision:
		collision.disabled = true

	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0

	if GameState.has_checkpoint and player_ref:
		_respawn_player()
	else:
		get_tree().reload_current_scene()

func _respawn_player() -> void:
	player_ref.global_position = GameState.checkpoint_position
	player_ref.velocity = Vector2.ZERO

	var collision := player_ref.get_node_or_null("CollisionShape2D")
	if collision:
		collision.disabled = false
