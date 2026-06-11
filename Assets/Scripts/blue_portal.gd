extends Area2D

var linked_portal: Area2D
var is_teleporting = false

func _on_body_entered(body):
	if body.is_in_group("Player") and !is_teleporting:
		linked_portal.is_teleporting = true
		
		# Convert velocity from entry portal local space to exit portal local space
		var local_velocity = to_local(body.global_position + body.velocity) - to_local(body.global_position)
		var rotated_velocity = linked_portal.to_global(local_velocity) - linked_portal.global_position

		# Teleport the player
		body.global_position = linked_portal.global_position
		
		# Apply the remapped velocity
		body.velocity = rotated_velocity

func _on_body_exited(body):
	if body.is_in_group("Player"):
		is_teleporting = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
