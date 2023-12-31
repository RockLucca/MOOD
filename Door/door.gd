extends Node3D

@export var key_color: Color = Color.WHITE
@export var tipe_open: bool = false

var has_key = false
var is_opening = false

func _ready() -> void:
	$Key.modulate = key_color
	$Door/DoorLight.light_color = key_color
	$Key/KeyLight.light_color = key_color
	if tipe_open == false: 
		$Door/Lado1.modulate = key_color
		$Door/Lado2.modulate = key_color

func _on_capture_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		has_key = true
		$Door/DoorLight.light_energy = 1
		$Key.queue_free()

func _on_door_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and has_key:
		if not is_opening:
			is_opening = true
			var tween = get_tree().create_tween()
			var endPosition
			if tipe_open == false:
				endPosition = $Door.position + Vector3(0, 4, 0)
			else:
				endPosition = $Door.position + Vector3(0, 0, 4)
			tween.tween_property($Door, "position", endPosition, 2)
			tween.tween_callback(queue_free)
