extends CPUParticles3D

var _look_at: Vector3
var _up: Vector3

func create_blood(pos: Vector3, normal: Vector3) -> void:
	global_position = pos
	_look_at = (pos + normal.normalized())
	_up = Vector3.RIGHT if (normal == Vector3(0, 1, 0) or normal == Vector3(0, -1, 0)) else Vector3.UP
	look_at_from_position(pos, _look_at, _up)
	emitting = true

func _on_timer_timeout() -> void:
	queue_free()
