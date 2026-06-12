extends Node2D

var held_object = false
var button1_active := false

func _ready():
	
	# Connecter les 2 protails
	$Orange_Portal.linked_portal = $Blue_Portal
	$Blue_Portal.linked_portal = $Orange_Portal
	
	print($TileMap.get_cell_source_id(0, Vector2i(-5, -5)))
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_clicked)
		
func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object
		
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity() / 5.0)
			held_object = null
