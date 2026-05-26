extends Area2D

var linked_portal: Area2D  # no @export, set from outside
var is_teleporting = false

func _on_body_entered(body):
	if body is PlayerController and !is_teleporting:
		linked_portal.is_teleporting = true
		body.global_position = linked_portal.global_position

func _on_body_exited(body):
	if body is PlayerController:
		is_teleporting = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
