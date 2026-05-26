extends Area2D

func _ready():
	$SpriteOn.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("pickable"):  # or check the class, up to you
		$SpriteOff.visible = false
		$SpriteOn.visible = true

func _on_body_exited(body):
	if body.is_in_group("pickable"):
		$SpriteOff.visible = true
		$SpriteOn.visible = false
