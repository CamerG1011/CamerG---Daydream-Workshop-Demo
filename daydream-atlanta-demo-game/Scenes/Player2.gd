extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const GRAVITY = 1900.0

@onready var anim = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump
	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle horizontal movement
	var direction = Input.get_axis("player2_left", "player2_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Move the player
	move_and_slide()

	# Change animation based on direction
	if direction > 0:
		anim.play("right")
	elif direction < 0:
		anim.play("left")
	else:
		anim.play("front")
		
