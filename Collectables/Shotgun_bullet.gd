extends Area3D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.shotgun_ammo += 10
		queue_free()
