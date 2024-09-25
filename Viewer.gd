class_name Viewer extends Node3D

enum AttackTypes {Flail,Sword}

var viewerName: String
var attacked: bool
var attackType: AttackTypes
var enemyToAttack: Enemy

@onready var animationPlayer = $astro_egg_1/AnimationPlayer
@onready var nameLabel = $NameLabel
signal attackDone
# Called when the node enters the scene tree for the first time.

func prepViwer(nameParam: String):
	setName(nameParam)

func prepViwerDebug():
	setName(str(get_instance_id()))

func setName(nameParam: String):
	viewerName = nameParam
	nameLabel.text = viewerName

func _ready():
	pass

func refresh():
	attacked = false

func changeAttack(attackTypeParam:AttackTypes):
	attackType = attackTypeParam

func attack(enemyParam: Enemy):
	animationPlayer.play("attack_animation",-1,1,false)
	enemyToAttack = enemyParam

func _on_animation_player_animation_finished(anim_name):
	var enemyDefeated = false
	if anim_name == "walking_animation":
		animationPlayer.play("walking_animation",-1,1,false)
	if anim_name == "attack_animation":
		match attackType:
			(AttackTypes.Flail):
				enemyDefeated = enemyToAttack.loseHealth(1)
			(AttackTypes.Sword):
				enemyDefeated = enemyToAttack.loseHealth(3)
	
	if enemyDefeated:
		animationPlayer.play("walking_animation",-1,1,false)
	else:
		attackDone.emit(get_instance_id())

