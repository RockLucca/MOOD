extends Area3D
var running = false

func _ready():
	$Timer.paused = true

func _on_body_entered(body):
	if body.is_in_group("Player") and not running:
		running = true
		$Timer.paused = false
		$Timer.start()
		$Label.show()
		Global.boost_damage *= 4
		$CollisionShape3D.disabled = true
		$Sprite3D.hide()

func _on_timer_timeout():
	Global.boost_damage = 1
	$Label.hide()
	queue_free()
