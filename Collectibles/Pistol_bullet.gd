extends Area3D

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.pistol_ammo += 7
		queue_free()
