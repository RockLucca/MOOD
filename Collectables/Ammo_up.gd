extends Area3D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.pistol_ammo += 25 
		Global.shotgun_ammo += 20
		Global.minigun_ammo += 60
		queue_free()
