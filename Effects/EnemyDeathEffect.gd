extends Node2D

func _ready():
	SoundFx.play("EnemyDie")

func _on_DustEffect9_tree_exited():
	queue_free()
