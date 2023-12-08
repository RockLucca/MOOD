extends Node3D

@onready var player = get_tree().get_first_node_in_group("player")

var _look_at: Vector3
var _up: Vector3

func create_decal(pos: Vector3, normal: Vector3) -> void:
	global_position = pos
	_look_at = (pos + normal.normalized())
	$MeshInstance3D.rotate_z(randf_range(-PI, PI))
	_up = Vector3.RIGHT if (normal == Vector3(0, 1, 0) or normal == Vector3(0, -1, 0)) else Vector3.UP
	look_at_from_position(pos, _look_at, _up)

func _on_timer_timeout() -> void:
	queue_free()
