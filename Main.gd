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
@onready var timer = $Timer
@onready var progressBar = $SubViewportContainer/SubViewport/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,false)
	get_tree().get_root().set_transparent_background(false)
	hBoxContainer.modulate.a = 0.5
	timer.process_callback
	
	# TODO: fill viewer from twitch api, only followers.
	for n in 20:
		var astroEggInst : Viewer = astroEggScene.instantiate()
		astroEggLocation.add_child(astroEggInst)
		astroEggInst.prepViwerDebug()
		astroEggInst.visible = false
		astroEggInst.attackDone.connect(_egg_attacked)
		viewers.append(astroEggInst)
	
func _process(delta):
	progressBar.value = timer.wait_time - timer.time_left
	pass

func _egg_attacked(emitterId: int):
	if currentViewerIndex >= viewers.size() || !currentEnemy.alive  || viewers[currentViewerIndex].get_instance_id() != emitterId:
		return
	
	viewers[currentViewerIndex].visible = false
	currentViewerIndex += 1
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = true
		viewers[currentViewerIndex].attack(currentEnemy)
	else:
		timer.start()
		

func start_battle():
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = false
	assaultRound += 1
	roundLabel.text = "Round %d" %assaultRound
	currentViewerIndex = 0
	null
	viewers.shuffle()
	
	if currentEnemy == null:
		currentEnemy = enemyScene.instantiate()
		currentEnemy.died.connect(_on_enemy_died)
		enemyLocation.add_child(currentEnemy)
	if !currentEnemy.alive:
		currentEnemy.spawn()
	if currentViewerIndex < viewers.size():
		viewers[currentViewerIndex].visible = true
		viewers[currentViewerIndex].attack(currentEnemy)

func  _on_enemy_died():
	#Check if the timer isn't already running, like when the last attacked.
	if timer.is_stopped():
		timer.start()


func _on_check_button_toggled(button_pressed):
	showStuff = button_pressed
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,!showStuff)
	get_tree().get_root().set_transparent_background(!showStuff)

func _on_button_pressed():
	start_battle()
		

func _on_h_box_container_mouse_entered():
	hBoxContainer.modulate.a = 1

func _on_h_box_container_mouse_exited():
	hBoxContainer.modulate.a = 0.5

func _on_timer_timeout():
	start_battle()
