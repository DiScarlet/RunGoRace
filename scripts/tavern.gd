extends Node

@onready var animation_player: AnimationPlayer = $Background/Night/AnimationPlayer

func _ready():
	GameState.change_night.connect(change_bg)
	
func change_bg():
	print("CHBYBFEFIUEIFU")
	animation_player.play("night")
