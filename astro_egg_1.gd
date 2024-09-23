extends Node3D

@onready var animationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animationPlayer.play("attack_animation",-1,1,false)

func _process(delta):
	pass

func _on_animation_player_animation_finished(anim_name):
	animationPlayer.play("attack_animation",-1,1,false)
