extends Area2D

var timer: SceneTreeTimer = null

func _ready():
	$SpriteOn.visible = false

func _on_end_area_body_entered(body):
	if body.is_in_group("Player"):
		$SpriteOff.visible = false
		$SpriteOn.visible = true
		timer = get_tree().create_timer(2.0)
		timer.timeout.connect(_on_timer_finished)

func _on_body_exited(body):
	if body.is_in_group("Player"):
		$SpriteOff.visible = true
		$SpriteOn.visible = false
		timer = null  # cancel the timer by dropping the reference

func _on_timer_finished():
	if timer != null:  # only triggers if player is still inside
		print("teleportation")
		timer = null
