class_name Enemy extends Node

var health: int
var alive: bool

func loseHealth(damage:int):
	health -= damage
	if health <= 0:
		alive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
