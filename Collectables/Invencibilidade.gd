extends Area3D

var temp = Global.player_health

func _ready():
	$Timer.paused = true

func _on_body_entered(body):
	if body.is_in_group("Player"):
		$Timer.paused = false
		$Timer.start()
		$Label.show()
		$CollisionShape3D.disabled = true
		$Sprite3D.hide()
		var temp = Global.player_health
		Global.player_health = 999

func _on_timer_timeout():
	$Label.hide()
	Global.boost_velocity = temp
	queue_free()
