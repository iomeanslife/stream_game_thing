extends Node3D

var showStuff = true
var viewers: Array
var currentViewerIndex: int
var currentEnemy: Enemy
@export var enemyScene: PackedScene
@export var astroEggScene: PackedScene

@onready var enemyLocation = $EnemyLocation
@onready var astroEggLocation = $AstroEggLocation

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,false)
	get_tree().get_root().set_transparent_background(false)
	
	# TODO: fill viewer from twitch api, only followers.
	for n in 20:
		var astroEggInst : Viewer = astroEggScene.instantiate()
		astroEggLocation.add_child(astroEggInst)
		astroEggInst.prepViwerDebug()
		astroEggInst.visible = false
		astroEggInst.attackDone.connect(_egg_attacked)
		viewers.append(astroEggInst)
	
func _process(delta):
	pass

func _egg_attacked(emitterId: int):
	if currentViewerIndex >= viewers.size():
		return
	if !currentEnemy.alive:
		return
	viewers[currentViewerIndex].visible = false
	currentViewerIndex += 1
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = true
		viewers[currentViewerIndex].attack(currentEnemy)
	
func _on_check_button_toggled(button_pressed):
	showStuff = button_pressed
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,!showStuff)
	get_tree().get_root().set_transparent_background(!showStuff)

func _on_button_pressed():
	if currentEnemy == null:
		currentEnemy = enemyScene.instantiate()
		enemyLocation.add_child(currentEnemy)
	if !currentEnemy.alive:
		currentEnemy.spawn()
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = true
		viewers[currentViewerIndex].attack(currentEnemy)
