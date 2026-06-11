extends CharacterBody2D

@export var speed = 10.0
@export var jump_power = 10.0
var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var portal_launched = false

func _physics_process(delta):
	# Gravité
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		portal_launched = false  # landed, clear the flag

	# Saut
	if Input.is_action_just_pressed("p2_up") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	direction = Input.get_axis("p2_gauche", "p2_droite")
	if direction:
		portal_launched = false  # player took manual control, cancel portal momentum
		velocity.x = direction * speed * speed_multiplier
	elif is_on_floor() or not portal_launched:
		# Stop only if on floor, or in air without portal momentum
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	# else: in air + portal_launched → leave velocity.x untouched

	move_and_slide()
