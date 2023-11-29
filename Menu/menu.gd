extends Control

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://Map Scenes/world.tscn")


func _on_instrucoes_pressed():
	pass # Replace with function body.


func _on_opcoes_pressed():
	pass # Replace with function body.


func _on_creditos_pressed():
	pass # Replace with function body.


func _on_sair_pressed():
	get_tree().quit()
