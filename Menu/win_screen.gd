extends Control

func _on_timer_timeout() -> void:
	Global.play_credits = true
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
