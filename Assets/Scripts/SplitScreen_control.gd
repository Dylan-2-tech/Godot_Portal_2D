extends Control

const PUNK_SCENE := preload("res://Assets/Scenes/punk.tscn")

@onready var view1: SubViewport = $HBox/Container1/View1
@onready var view2: SubViewport = $HBox/Container2/View2


func _ready():
	_setup_level()

func _setup_level():
	view2.world_2d = view1.world_2d
	var level := view1.get_child(0)
	view2.world_2d = view1.world_2d

	var cyborg := level.get_node("Cyborg")

	var punk := PUNK_SCENE.instantiate()
	level.add_child(punk)
	punk.global_position = cyborg.global_position + Vector2(60, 0)

	# Camera 1 → left screen
	var cam1: Camera2D = cyborg.get_node("Camera2D")
	cam1.make_current()

	# Camera 2 → right screen
	var cam2: Camera2D = punk.get_node("Camera2D")
	cam2.custom_viewport = view2
	cam2.make_current()

func load_new_level(path: String):
	var old_level := view1.get_child(0)
	view1.remove_child(old_level)
	old_level.queue_free()
	
	var new_level: Node = load(path).instantiate()
	view1.add_child(new_level)
	_setup_level()  # re-run all the setup for the new level

	
