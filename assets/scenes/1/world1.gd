extends Node2D
var cLevel = 1
var a = false

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	newLevel(cLevel)
	data.sceneData.Player = $Player
	data.sceneData.World = self
func newLevel(i):
	var old = get_node_or_null("Level")
	if old != null:
		remove_child(old)
	var n = load("res://assets/scenes/1/levels/" + str(i) + ".tscn").instantiate()
	add_child(n)
	move_child(n, 0)
	n.name = "Level"
func _ready():
	$Music.play()

func nextLevel():
	if a:
		return
	a = true
	cLevel += 1
	newLevel(cLevel)
	$Player.varReset()
	await get_tree().create_timer(0.5).timeout
	a = false
