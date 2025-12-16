extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D

var is_frozen: bool = false
var is_attacking: bool = false 

func _ready():
	# Only listen for Dialogue Manager to freeze/unfreeze player
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
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
		play_attack_logic()
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




func _on_attack_command_received():
	play_attack_logic()
# New function to handle the attack sequence cleanly
func play_attack_logic():
	is_attacking = true
	animated_sprite.play("attack1") # Ensure 'Loop' is OFF in Sprite Frames
	await animated_sprite.animation_finished
	is_attacking = false
	# Tell the dialogue system the attack is finished
	GameState.player_performed_attack.emit()
