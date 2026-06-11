extends Node

const PUNK_SCENE := preload("res://Assets/Scenes/punk.tscn")

@onready var view1: SubViewport = $HBox/Container1/View1
@onready var view2: SubViewport = $HBox/Container2/View2

func _ready():
	# Les deux viewports affichent LE MÊME monde
	view2.world_2d = view1.world_2d

	# Le niveau instancié dans View1
	var level := view1.get_child(0)

	# Récupère le cyborg déjà présent dans le niveau
	var cyborg := level.get_node("Cyborg")

	# Fait apparaître le punk (joueur 2) à côté du cyborg
	var punk := PUNK_SCENE.instantiate()
	level.add_child(punk)
	punk.global_position = cyborg.global_position + Vector2(60, 0)

	# Caméra 1 → écran de gauche
	var cam1: Camera2D = cyborg.get_node("Camera2D")
	cam1.make_current()

	# Caméra 2 → redirigée vers l'écran de droite
	var cam2: Camera2D = punk.get_node("Camera2D")
	cam2.custom_viewport = view2
	cam2.make_current()
	
	var bg := level.get_node("Background")
	var bg_copy := bg.duplicate()
	view2.add_child(bg_copy)
