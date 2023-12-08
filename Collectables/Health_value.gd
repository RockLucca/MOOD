extends Area3D

func _on_body_entered(body):
	if body.is_in_group("Player") and Global.player_health < 100:
		Global.player_health += 20
		queue_free()
		if Global.player_health > 100:
			Global.player_health = 100
