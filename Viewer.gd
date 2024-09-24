class_name Viewer extends Node3D

enum AttackTypes {Flail,Sword}

var viewerName: String
var attacked: bool
var attackType: AttackTypes
var enemyToAttack: Enemy

@onready var animationPlayer = $astro_egg_1/AnimationPlayer
# Called when the node enters the scene tree for the first time.

static func create(nameParam: String) -> Viewer:
	var viewer = Viewer.new()
	viewer.viewerName = nameParam
	return viewer
	
static func createDebug() -> Viewer:
	var viewer = Viewer.new()
	viewer.viewerName = str( viewer.get_instance_id())
	return viewer

func refresh():
	attacked = false

func changeAttack(attackTypeParam:AttackTypes):
	attackType = attackTypeParam

func attack(enemyParam: Enemy):
	animationPlayer.play("attack_animation",-1,1,false)
	enemyToAttack = enemyParam
	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack_animation":
		match attackType:
			(AttackTypes.Flail):
				enemyToAttack.loseHealth(1)
			(AttackTypes.Sword):
				enemyToAttack.loseHealth(3)
	#animationPlayer.play("attack_animation",-1,1,false)

