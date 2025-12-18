extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = %AnimatedSprite2DPlayer

var is_frozen: bool = false
var is_attacking: bool = false 

func _ready():
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	GameState.player_attack_villager.connect(_on_attack_command_received)
	GameState.request_attack.connect(_on_got_attacked_command_received)
	GameState.player_die.connect(_on_die)
	GameState.full_attack.connect(_on_full_attack)
	GameState.show_final_scene.connect(_on_final_redirect)

func _on_final_redirect():
	get_tree().change_scene("res://final.tscn")
	await get_tree().create_timer(10, true).timeout
	get_tree().change_scene("res://scenes/game.tscn")

func _on_full_attack():
	is_attacking = true
	animated_sprite.play("attack1")
	await animated_sprite.animation_finished
	animated_sprite.play("attack2")
	await animated_sprite.animation_finished
	animated_sprite.play("attack3")
	await animated_sprite.animation_finished
	is_attacking = false
	animated_sprite.play("default")
	GameState.player_finished_attack.emit()
	
func _on_die():
	print("DEAD")
	Engine.time_scale = 0.5
	$CollisionShape2D.queue_free()
	await get_tree().create_timer(1.5, true).timeout
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _on_got_attacked_command_received():
	print("was hurt")
	animated_sprite.play("hurt")
	await animated_sprite.animation_finished
	animated_sprite.play("default")
	
func _on_attack_command_received():
	# 1. Stop movement animations
	is_attacking = true
	# 2. Play the attack
	animated_sprite.play("attack1")
	# 3. Wait for it to finish
	await animated_sprite.animation_finished
	# 4. Allow idle animations again
	is_attacking = false
	animated_sprite.play("default")
	GameState.player_finished_attack.emit()
	
func _on_dialogue_started(_resource: DialogueResource):
	is_frozen = true
	velocity = Vector2.ZERO 
	animated_sprite.play("default")

func _on_dialogue_ended(_resource: DialogueResource):
	is_frozen = false

func _physics_process(delta: float) -> void:
	# 1. ALLOW ATTACK INPUT ALWAYS
	# We check this first so the player can press 'L' to advance the dialogue
	if Input.is_action_just_pressed("attack") and not is_attacking:
		_on_attack_command_received()
		return

	# 2. DIALOGUE & ATTACK LOCK
	# If the dialogue is open or we are mid-animation, stop all movement logic
	if is_frozen or is_attacking:
		velocity.x = move_toward(velocity.x, 0, SPEED) # Friction stop
		if not is_on_floor():
			velocity += get_gravity() * delta # Still apply gravity so you don't float
		move_and_slide()
		return

	# 3. GRAVITY
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 4. JUMPING
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 5. MOVEMENT (L/R)
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip Sprite based on direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# 6. MOVEMENT ANIMATIONS
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
		else: 
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	# 7. APPLY VELOCITY
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 8. EXECUTE MOVEMENT
	move_and_slide()
