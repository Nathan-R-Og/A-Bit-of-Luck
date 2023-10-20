extends Node

var sceneData = {
	"Player": null,
	"World": null,
	
	
	
}



var Aspect = 1



func _ready():
	resize()


func resize():
	var s = Vector2(480, 360)
	var res = s * (Aspect + 1)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, res.x >= 1920 or res.y >= 1080)
	DisplayServer.window_set_size(res)
	DisplayServer.window_set_position(DisplayServer.window_get_position() - Vector2i((res - s) / 2.0))
