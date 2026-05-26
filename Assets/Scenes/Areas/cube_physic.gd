extends RigidBody2D

signal clicked

var held = false

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked.emit(self)

func _physics_process(delta):
	if held:
		var target = get_global_mouse_position()
		var motion = target - global_position
		var collision = move_and_collide(motion)
		if collision:
			# Slide along the surface instead of stopping
			var remaining = collision.get_remainder().slide(collision.get_normal())
			move_and_collide(remaining)

func pickup():
	if held:
		return
	freeze = true
	held = true
	
func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
