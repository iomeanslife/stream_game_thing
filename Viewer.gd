class_name Viewer extends Node

enum AttackTypes {Flail,Sword}

var viewerName: String
var attacked: bool
var attackType: AttackTypes

static func create(nameParam: String) -> Viewer:
	var viewer = Viewer.new()
	viewer.viewerName = nameParam
	return viewer
	
func refresh():
	attacked = false

func changeAttack(attackTypeParam:AttackTypes):
	attackType = attackTypeParam

func attack(enemyParam: Enemy):
	match attackType:
		(AttackTypes.Flail):
			enemyParam.loseHealth(1)
		(AttackTypes.Sword):
			enemyParam.loseHealth(3)
	
