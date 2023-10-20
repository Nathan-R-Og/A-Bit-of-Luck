extends Node
var spikeInst = preload("res://assets/scenes/1/spikeInst.tscn")

func _ready():
	for each in $TileMap.get_used_cells_by_id(0, 2):
		var new = spikeInst.instantiate()
		new.global_position = $TileMap.global_position + $TileMap.map_to_local(each)
		$TileMap.set_cell(0, each, -1)
		$Hazards.call_deferred("add_child", new)
	for each in $Wins.get_children():
		each.connect("body_entered", Callable(self, "winTouch"))
func winTouch(body):
	if body.get_parent() == data.sceneData.Player:
		data.sceneData.World.nextLevel()
