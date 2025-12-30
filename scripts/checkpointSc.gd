extends Area2D

@export var checkpoint_id: String = "CP_1"

func _on_body_entered(body: Node2D) -> void:
	print("Entered")
	if body.is_in_group("Player"):
		GameState.checkpoint_position = global_position
		GameState.has_checkpoint = true
		GameState.checkpoint_updated.emit(global_position)
		print("✅ Checkpoint saved:", checkpoint_id)
