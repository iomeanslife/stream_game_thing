extends Node3D

var showStuff = true
var viewers: Array
var currentViewerIndex: int
var currentEnemy: Enemy
var assaultRound: int = 0

@export var enemyScene: PackedScene
@export var astroEggScene: PackedScene

@onready var enemyLocation = $EnemyLocation
@onready var astroEggLocation = $AstroEggLocation
@onready var roundLabel = $SubViewportContainer/SubViewport/HBoxContainer/RoundCounter
@onready var hBoxContainer = $SubViewportContainer/SubViewport/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,false)
	get_tree().get_root().set_transparent_background(false)
	hBoxContainer.modulate.a = 0.5
	
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
	if currentViewerIndex >= viewers.size() || !currentEnemy.alive  || viewers[currentViewerIndex].get_instance_id() != emitterId:
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
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = false
	assaultRound += 1
	roundLabel.text = "Round %d" %assaultRound
	currentViewerIndex = 0
	randomize()
	viewers.shuffle()
	
	if currentEnemy == null:
		currentEnemy = enemyScene.instantiate()
		enemyLocation.add_child(currentEnemy)
	if !currentEnemy.alive:
		currentEnemy.spawn()
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = true
		viewers[currentViewerIndex].attack(currentEnemy)



func _on_h_box_container_mouse_entered():
	hBoxContainer.modulate.a = 1
	pass # Replace with function body.



func _on_h_box_container_mouse_exited():
	hBoxContainer.modulate.a = 0.5
