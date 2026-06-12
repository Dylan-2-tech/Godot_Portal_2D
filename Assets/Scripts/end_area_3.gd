extends Area2D

@export var other_button: Area2D  # assign the cube button in the Inspector

var timer: SceneTreeTimer = null

func _ready():
	$SpriteOn.visible = false

func _on_end_area_body_entered(body):
	if body.is_in_group("Player"):
		$SpriteOff.visible = false
		$SpriteOn.visible = true
		if other_button and other_button._is_active:
			timer = get_tree().create_timer(2.0)
			timer.timeout.connect(_on_timer_finished)

func _on_body_exited(body):
	if body.is_in_group("Player"):
		$SpriteOff.visible = true
		$SpriteOn.visible = false
		timer = null

func _on_timer_finished():
	if timer != null:
		timer = null
		get_tree().change_scene_to_file("res://Assets/Scenes/level_4_solo.tscn")
