extends CharacterBody2D

# === Movement Constants ===
const SPEED = 600.0
const JUMP_VELOCITY = -900.0
const GRAVITY = 1900.0

# === Node References ===
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep_particles: CPUParticles2D = $FootstepParticles


# === Surface Textures Table ===
var surface_textures := {
	"grass": preload("res://Assets/pixel_art (1).png"),
	"stone": preload("res://Assets/pixel_art (11).png"),
	"wood": preload("res://Assets/pixel_art (13).png"),
}

# === State ===
var current_surface: String = "grass"  # Default surface

func _ready():
	for area in get_tree().get_nodes_in_group("surface_areas"):
		if area.has_signal("body_entered"):
			area.body_entered.connect(
				func(body):
					if body == self and "surface_type" in area:
						current_surface = area.surface_type
			)


func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jumping
	if Input.is_action_just_pressed("player2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal Movement
	var direction = Input.get_axis("player2_left", "player2_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Apply Movement
	move_and_slide()

	# Animation Control
	if direction > 0:
		anim.play("right")
	elif direction < 0:
		anim.play("left")
	else:
		anim.play("front")

	# Play Footstep Particles if walking on ground
	if is_on_floor() and abs(velocity.x) > 10:
		play_footstep()

func play_footstep():
	if footstep_particles == null:
		return

	var texture = surface_textures.get(current_surface)
	if texture:
		footstep_particles.texture = texture
		
		# Force re-emission properly
		footstep_particles.emitting = false
		await get_tree().process_frame  # ensure state resets
		footstep_particles.emitting = true
	else:
		print("No texture found for surface:", current_surface)
