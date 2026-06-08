extends Area2D
class_name Portal

@export var exit_offset := 32.0       # distance de sortie devant le portail
@export var min_exit_speed := 200.0   # éjection minimale hors du portail de sortie

var linked_portal: Portal
var _cooldown := 0.0

func _ready():
	body_entered.connect(_on_body_entered)

func _process(delta):
	if _cooldown > 0.0:
		_cooldown -= delta

func _on_body_entered(body):
	if _cooldown > 0.0 or linked_portal == null:
		return
	if body is PlayerController:
		_teleport(body)

func _teleport(body: PlayerController):
	_cooldown = 0.3
	linked_portal._cooldown = 0.3

	# Réoriente la vélocité selon l'angle relatif des portails (direction + magnitude)
	var rel_angle := linked_portal.global_rotation - global_rotation + PI
	body.velocity = body.velocity.rotated(rel_angle)

	# Direction "vers l'extérieur" du portail de sortie
	var exit_normal := Vector2.RIGHT.rotated(linked_portal.global_rotation)

	# Garantit une éjection minimale vers l'extérieur.
	# Sans ça, une entrée lente (saut, apex) ressort sans élan → chute droite.
	var along := body.velocity.dot(exit_normal)
	if along < min_exit_speed:
		body.velocity += exit_normal * (min_exit_speed - along)

	body.global_position = linked_portal.global_position + exit_normal * exit_offset
