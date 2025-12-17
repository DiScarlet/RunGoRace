extends Area2D

@onready var timer = $Timer 
@export var killzone_id: String = "Unknown"
	
func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		print("🚫 Ignored non-player body:", body.name)
		return
	Engine.time_scale = 0.5
	print("You are kicked out of the open lobby")
	print("☠️ Player entered killzone:", killzone_id)
	print("➡️ Body name:", body.name)
	print("➡️ Body type:", body.get_class())
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
