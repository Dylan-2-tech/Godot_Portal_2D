extends Area2D
class_name Portal

@export var exit_offset := 32.0   # distance de sortie devant le portail (évite de spawn dans le mur)

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
	# Petit délai des deux côtés pour éviter le rebond immédiat
	_cooldown = 0.3
	linked_portal._cooldown = 0.3

	# +PI : on entre par une face, on ressort par l'autre
	var rel_angle := linked_portal.global_rotation - global_rotation + PI

	# Vélocité : direction ET magnitude conservées, juste réorientées
	body.velocity = body.velocity.rotated(rel_angle)

	# Position : juste devant le portail de sortie, le long de sa normale
	var exit_normal := Vector2.RIGHT.rotated(linked_portal.global_rotation)
	body.global_position = linked_portal.global_position + exit_normal * exit_offset
