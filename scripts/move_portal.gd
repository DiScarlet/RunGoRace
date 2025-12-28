extends Node2D
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("TRANSPORTED")
	print(name)
	transport(str(name))
	
func transport(destination: String) -> void:
	var path = "res://scenes/" + destination + ".tscn"
	print(path)
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(path)
