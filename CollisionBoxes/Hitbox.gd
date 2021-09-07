extends Area2D

export(int) var damage = 1


func _on_Hitbox_area_entered(hurtbox): #hitboxes should only collide with  hurtboxes 
	hurtbox.emit_signal("hit", damage)
