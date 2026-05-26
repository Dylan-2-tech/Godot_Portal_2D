extends Camera2D

@export var speed: float = 300.0

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= speed * delta
	if Input.is_action_pressed("ui_right"):
		position.x += speed * delta
