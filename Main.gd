extends Node2D

var hideStuff = true
var viewers: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,hideStuff)
	get_tree().get_root().set_transparent_background(hideStuff)
	viewers
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_click():
	hideStuff = !hideStuff
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,hideStuff)
	get_tree().get_root().set_transparent_background(hideStuff)
	
