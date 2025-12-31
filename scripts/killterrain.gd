extends Area2D

@export var killterrain_id: String = "Unknown"

var is_dying = false

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player") and not is_dying:
		print("Awoided ")
		return
		
	is_dying = true
	print("Entererd killterrain " + killterrain_id)
	GameState.player_die_terrain.emit()
	
	await GameState.finished_dying
	is_dying = false
