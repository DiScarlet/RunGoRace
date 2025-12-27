extends Node

signal request_attack
signal player_attack_villager
signal ork_start_attack
signal ork_attack
signal player_die
signal player_finished_attack
signal ork_back_default
signal full_attack
signal crescent_captain_attack
signal crescent_captain_die
signal show_final_scene
signal send_to_mother_1
signal mother1_end
signal restore_position

func _ready():
	GameState.mother1_end.connect(_on_mother_finished)

func _on_mother_finished():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
	# wait for scene to actually become active
	await get_tree().scene_changed
	
	_restore_player_position()

func _restore_player_position():
	var scene = get_tree().current_scene
	if scene == null:
		push_error("Scene not loaded yet")
		return

	var player = scene.get_node_or_null("Player")
	if player:
		print("RESTORED")
		player.global_position = Vector2(6316.0, -51)
