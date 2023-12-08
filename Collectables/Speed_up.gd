extends Area3D

func _ready():
	$Timer.paused = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$Timer.paused = false
		$Timer.start()
		$Label.show()
		Global.boost_velocity *= 2
		$CollisionShape3D.disabled = true
		$Sprite3D.hide()

func _on_timer_timeout():
	Global.boost_velocity = 1
	$Label.hide()
	queue_free()
