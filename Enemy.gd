class_name Enemy extends Node3D

var health: int
var alive: bool

@onready var healthLabel :Label3D = $HealthLabel

func loseHealth(damage:int):
	health -= damage
	if health <= 0:
		alive = false
		healthLabel.visible = false
	healthLabel.text = "%i/10" % health 

func spawn():
	alive = true
	health = 10
	healthLabel.text = "10/10"
	healthLabel.visible = true
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
