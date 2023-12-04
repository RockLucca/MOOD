extends Control

func _on_jogar_pressed():
	await get_tree().create_timer(0.6).timeout
	get_tree().change_scene_to_file("res://Map Scenes/world.tscn")


func _on_instrucoes_pressed():
	await get_tree().create_timer(0.6).timeout
	pass # Replace with function body.


func _on_opcoes_pressed():
	await get_tree().create_timer(0.6).timeout
	pass # Replace with function body.


func _on_creditos_pressed():
	await get_tree().create_timer(0.6).timeout
	pass # Replace with function body.


func _on_sair_pressed():
	await get_tree().create_timer(0.6).timeout
	get_tree().quit()
