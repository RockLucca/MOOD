extends Area3D

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.minigun_ammo += 50
		queue_free()
