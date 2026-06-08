extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Gravité
	if not is_on_floor():
		velocity.y += gravity * delta

	# Saut
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_power * jump_multiplier

	direction = Input.get_axis("gauche", "droite")

	if direction:
		# Contrôle total quand on appuie sur une direction
		velocity.x = direction * speed * speed_multiplier
	elif is_on_floor():
		# Friction UNIQUEMENT au sol
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
	# En l'air + aucune touche : on ne touche PAS velocity.x
	# → l'élan donné par le portail est conservé, la gravité fait l'arc

	move_and_slide()
