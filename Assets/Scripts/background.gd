extends Node2D

@export var scroll_speed := 0.2  # parallax factor, 1.0 = moves with camera
@export var camera: Camera2D

func _process(delta):
	if camera:
		position.x = -camera.global_position.x * scroll_speed
