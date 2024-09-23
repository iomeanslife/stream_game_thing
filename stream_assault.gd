extends Node3D

var showStuff = true
var viewers: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,false)
	get_tree().get_root().set_transparent_background(false)
	
	
	pass
	
func _process(delta):
	pass


func _on_check_button_toggled(button_pressed):
	showStuff = button_pressed
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,!showStuff)
	get_tree().get_root().set_transparent_background(!showStuff)
