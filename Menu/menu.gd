extends Control

@onready var curr_scene = $Main

func change_screen(scene):
	curr_scene.visible = false
	curr_scene = scene
	curr_scene.visible = true

func _on_jogar_pressed():
	get_tree().change_scene_to_file("res://Map Scenes/world.tscn")

func _on_instrucoes_pressed():
	change_screen($Instrucoes)


func _on_opcoes_pressed():
	change_screen($Opcoes)


func _on_creditos_pressed():
	change_screen($Creditos)


func _on_sair_pressed():
	get_tree().quit()

func _on_voltar_pressed() -> void:
	change_screen($Main)
