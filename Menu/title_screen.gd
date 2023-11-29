extends Control

@export_file("*.tscn") var _scene: String = "res://Menu/menu.tscn"

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene_to_file(_scene)


func _on_button_pressed():
		get_tree().change_scene_to_file(_scene)
