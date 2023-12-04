extends Control

@onready var curr_scene = $Main

func change_screen(scene):
	curr_scene.visible = false
	curr_scene = scene
	curr_scene.visible = true
	
func _process(delta: float) -> void:
	if curr_scene == $Creditos:
		await get_tree().create_timer(1).timeout
		$Creditos/CreditosText.global_position.y -= 1

func _on_jogar_pressed():
	await get_tree().create_timer(0.6).timeout
	get_tree().change_scene_to_file("res://Map Scenes/world.tscn")

func _on_instrucoes_pressed():
	await get_tree().create_timer(0.6).timeout
	change_screen($Instrucoes)

func _on_opcoes_pressed():
	await get_tree().create_timer(0.6).timeout
	change_screen($Opcoes)

func _on_creditos_pressed():
	await get_tree().create_timer(0.6).timeout
	change_screen($Creditos)

func _on_sair_pressed():
	await get_tree().create_timer(0.6).timeout
	get_tree().quit()

func _on_voltar_pressed() -> void:
	change_screen($Main)
