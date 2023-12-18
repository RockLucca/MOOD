extends Node3D

@export var key_color: Color = Color.WHITE

var has_key = false
var is_opening = false

func _ready() -> void:
	$Key.modulate = key_color
	$Door/Lado1.modulate = key_color
	$Door/Lado2.modulate = key_color
	$Door/OmniLight3D.light_color = key_color

func _on_capture_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		has_key = true
		$Key.queue_free()

func _on_door_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player") and has_key:
		if not is_opening:
			is_opening = true
			var tween = get_tree().create_tween()
			var endPosition = $Door.position + Vector3(0, 4, 0)
			
			tween.tween_property($Door, "position", endPosition, 2)
			tween.tween_callback(queue_free)
			

