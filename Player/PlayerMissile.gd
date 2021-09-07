extends "res://Player/Projectile.gd"

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
const BRICK_LAYER_BIT = 6

func _ready():
	SoundFx.play("EnemyDie")

func _on_Hitbox_body_entered(body):
	if body.get_collision_layer_bit(BRICK_LAYER_BIT):
		Utils.instance_scene_on_main(EnemyDeathEffect, body.global_position + Vector2(8, 8))
		body.queue_free()
		
	#._on_Hitbox_body_entered(body)
