extends Node2D

var hideStuff = true

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,hideStuff)
	get_tree().get_root().set_transparent_background(hideStuff)
#	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, hideStuff)

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()

func on_click():
	hideStuff = !hideStuff
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,hideStuff)
	get_tree().get_root().set_transparent_background(hideStuff)
	#DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, hideStuff)
