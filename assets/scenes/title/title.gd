extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Start.connect("mouse_entered", Callable(self, "mouse").bind(1))
	$Start.connect("mouse_exited", Callable(self, "mouse").bind(-1))
	
	$Start.connect("input_event", Callable(self, "buttonInput"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func buttonInput(viewport, event, shape_idx):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://assets/scenes/1/node_2d.tscn")

func mouse(way):
	match way:
		1:
			$Start/s.scale = Vector2(.8, .8)
			$Start/s.modulate = Color("#4a4a4a")
		-1:
			$Start/s.scale = Vector2.ONE
			$Start/s.modulate = Color("#FFFFFF")


