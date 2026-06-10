extends Area2D

func _ready():
	$SpriteOn.visible = false

func _on_end_area_body_entered(body):
	if body.is_in_group("Player"):  # or check the class, up to you
		$SpriteOff.visible = false
		$SpriteOn.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		$SpriteOff.visible = true
		$SpriteOn.visible = false


