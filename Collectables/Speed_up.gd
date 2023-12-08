extends Area3D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.boost_velocity *= 2
		await get_tree().create_timer(5).timeout
		Global.boost_velocity = 1
		queue_free()
