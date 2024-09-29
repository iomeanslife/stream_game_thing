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
@onready var access_token_box = $SubViewportContainer/SubViewport/HBoxContainer/AccessToken
@onready var web_stuff = $WebStuff

# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT,false)
	get_tree().get_root().set_transparent_background(false)
	hBoxContainer.modulate.a = 0.5
	
	web_stuff.twitch_ready.connect(_twitch_ready)
	
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
	#moderator:read:chatter
	#moderator:read:followers
	#randomnise and check state for CRSS protection
	OS.shell_open("https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=qgmf0q1vpsnljxxlq654nr17rm2jcq&redirect_uri=http://localhost:3000/&scope=moderator%3Aread%3Afollowers+moderator%3Aread%3Achatters&state=c3ab8aa609ea11e793ae92361f002671")

func _on_h_box_container_mouse_entered():
	hBoxContainer.modulate.a = 1

func _on_h_box_container_mouse_exited():
	hBoxContainer.modulate.a = 0.5

func _on_timer_timeout():
	start_battle()
	
func _on_access_token_text_submitted(new_text):
	web_stuff.set_access_token(new_text)
	access_token_box.clear()
	
func _twitch_ready():
	timer.start()
	pass
