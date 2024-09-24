class_name Enemy extends Node3D

var health: int
var maxHealth: int
var alive: bool = false
var level: int

@onready var healthLabel :Label3D = $HealthLabel

func loseHealth(damage:int):
	health -= damage
	if health <= 0:
		alive = false
		healthLabel.visible = false
		level += 1
	healthLabel.text = "%d/%d" % [health, maxHealth]

func spawn():
	alive = true
	maxHealth = 10 + level * 5
	health = maxHealth
	print(healthLabel)
	healthLabel.text = "%d/%d" % [health, maxHealth]
	healthLabel.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
