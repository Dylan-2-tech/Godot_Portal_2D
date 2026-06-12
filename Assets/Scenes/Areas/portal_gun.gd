extends Node2D
class_name PortalGun

@export var blue_portal: Portal
@export var orange_portal: Portal
@export var max_range := 2000.0
@export_flags_2d_physics var wall_mask := 1
@export var show_duration := 0.15   # durée d'apparition du pistolet au tir

@onready var pivot: Node2D = $Pivot
@onready var muzzle: Marker2D = $Pivot/Muzzle
@onready var sprite: Sprite2D = $Pivot/Sprite2D

var _laser_from := Vector2.ZERO
var _laser_to := Vector2.ZERO
var _show_timer := 0.0

func _ready():
	sprite.visible = false
	_connect_portals()

func _connect_portals() -> void:
	# Réessaie chaque frame jusqu'à trouver les deux portails
	while blue_portal == null or orange_portal == null:
		if blue_portal == null:
			blue_portal = get_tree().get_first_node_in_group("blue_portal")
		if orange_portal == null:
			orange_portal = get_tree().get_first_node_in_group("orange_portal")
		if blue_portal == null or orange_portal == null:
			await get_tree().process_frame

# Mémorise l'état précédent des boutons pour détecter le "juste pressé"
var _was_left_pressed := false
var _was_right_pressed := false

func _physics_process(_delta):
	# La visée continue en arrière-plan, même pistolet invisible
	pivot.look_at(get_global_mouse_position())
	sprite.flip_v = absf(pivot.global_rotation) > PI / 2.0

	# Lecture directe de la souris : insensible au routage des SubViewports
	var left := Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	var right := Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)

	if Input.is_action_pressed("shift"):
		if left and not _was_left_pressed:
			_fire(blue_portal)
		if right and not _was_right_pressed:
			_fire(orange_portal)

	_was_left_pressed = left
	_was_right_pressed = right
	

func _process(delta):
	if _show_timer > 0.0:
		_show_timer -= delta
		if _show_timer <= 0.0:
			sprite.visible = false
			queue_redraw()   # efface le laser


func _fire(portal: Portal):
	if portal == null:
		return
	var from := muzzle.global_position
	var dir := Vector2.RIGHT.rotated(pivot.global_rotation)
	var to := from + dir * max_range

	var space := get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(from, to)
	query.collision_mask = wall_mask
	if get_parent() is CollisionObject2D:
		query.exclude = [get_parent().get_rid()]
	var hit := space.intersect_ray(query)

	if hit:
		portal.global_position = hit.position
		portal.global_rotation = hit.normal.angle()
		_laser_to = hit.position
	else:
		_laser_to = to

	_laser_from = from

	# Affiche le pistolet + le laser pendant show_duration
	sprite.visible = true
	_show_timer = show_duration
	queue_redraw()

func _draw():
	if _show_timer > 0.0:
		draw_line(to_local(_laser_from), to_local(_laser_to), Color(0.4, 0.8, 1.0), 3.0)
		
		
