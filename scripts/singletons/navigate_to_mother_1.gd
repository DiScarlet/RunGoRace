extends Node

func _ready():
	print("Orc script ready")
	GameState.send_to_mother_1.connect(transition_start)
	
func transition_start():
	print("PASSED OUT")
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/mother_meet.tscn")
	
