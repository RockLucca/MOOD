extends Area3D

var temp = Global.player_health
var running = false

func _ready():
	$Timer.paused = true

func _on_body_entered(body):
	if body.is_in_group("Player") and not running:
		running = true
		$Timer.paused = false
		$Timer.start()
		$Label.show()
		$CollisionShape3D.disabled = true
		$Sprite3D.hide()
		var temp = Global.player_health
		Global.player_health = 999

func _on_timer_timeout():
	$Label.hide()
	Global.player_health = temp
	queue_free()
