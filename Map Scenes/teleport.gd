extends Area3D

@export_file("*.tscn") var _scene: String

func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.boost_damage = 1
		Global.boost_firerate = 1
		Global.boost_velocity = 1
		get_tree().change_scene_to_file(_scene)
