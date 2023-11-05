extends Button

@export_file("*.tscn") var _scene: String = "res://Menu/menu.tscn"

func _on_button_up() -> void:
	get_tree().change_scene_to_file(_scene)
