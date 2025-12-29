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

signal restore_position
signal start_mother(dialogueInd: int)
signal dialogue_mother_1
signal dialogue_mother_2
signal mother_end(dialogueInd: int)

signal change_night

signal defector_attack
signal defector_hurt
signal defector_idle

func _ready():
	GameState.start_mother.connect(_on_mother_start)
	GameState.mother_end.connect(_on_mother_finished)

func _on_transition_start():
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	
func _on_mother_start(dialogueInd: int) -> void:
	print("PASSED OUT, dialogue:", dialogueInd)

	_on_transition_start()
	get_tree().change_scene_to_file("res://scenes/mother_meet.tscn")

	# wait until the scene is fully loaded
	await get_tree().scene_changed

	if dialogueInd == 1:
		GameState.dialogue_mother_1.emit()
	elif dialogueInd == 2:
		GameState.dialogue_mother_2.emit()
	
func _on_mother_finished(dialogueInd: int):
	_on_transition_start()
	
	get_tree().change_scene_to_file("res://scenes/game.tscn")
	
	# wait for scene to actually become active
	await get_tree().scene_changed
	
	_restore_player_position(dialogueInd)

func _restore_player_position(dialogueInd: int):
	var scene = get_tree().current_scene
	if scene == null:
		push_error("Scene not loaded yet")
		return
		
	var new_position
	if(dialogueInd == 1):
		new_position = Vector2(1127.0, 115.0)
	elif (dialogueInd == 2):
		new_position = Vector2(6382.0, -51)
	elif (dialogueInd == 100):
		new_position = Vector2(6382.0, -51)
	var player = scene.get_node_or_null("Player")
	if player:
		print("RESTORED")
		player.global_position = new_position
