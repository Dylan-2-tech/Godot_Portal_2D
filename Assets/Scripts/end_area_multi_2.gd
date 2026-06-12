extends Area2D

var _is_active := false  # ← add this

func _ready():
	$SpriteOn.visible = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		_is_active = true
		$SpriteOff.visible = false
		$SpriteOn.visible = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		_is_active = false
		$SpriteOff.visible = true
		$SpriteOn.visible = false
