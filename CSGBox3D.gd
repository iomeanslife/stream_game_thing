extends CSGBox3D


# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,true)
	get_tree().get_root().set_transparent_background(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#pass
	rotate_x(1 * delta)
