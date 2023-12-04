extends Control

@export_file("*.tscn") var _scene: String = "res://Menu/menu.tscn"

func _ready():
	$UI.hide()
	$UI/Abertura.play()
	$Animation/AnimationPlayer.play("apresentacao")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			get_tree().change_scene_to_file(_scene)

func _on_button_pressed():
		get_tree().change_scene_to_file(_scene)

func _on_animation_player_animation_finished(anim_name):
	$Animation/AnimationPlayer.stop()
	$Animation.hide()
	$UI.show()
