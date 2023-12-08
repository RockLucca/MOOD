extends Area3D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		printt("Pegou")
		Global.bust_velocity *= 2
		$Timer.start()
		queue_free()

func _on_timer_timeout():
	printt("Deu bom")
	Global.bust_velocity = 1
