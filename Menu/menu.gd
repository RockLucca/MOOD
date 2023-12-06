extends Control

@onready var curr_scene = $Main
@onready var creditos_text = $Creditos/CreditosSubindo
@onready var credits_initial_pos = creditos_text.global_position
@onready var master_audio = AudioServer.get_bus_index("Master")
@onready var ui_audio = AudioServer.get_bus_index("UI")
@onready var guns_audio = AudioServer.get_bus_index("Guns")
@onready var ambient_audio = AudioServer.get_bus_index("Ambient")

var credits_rolling = false

func change_screen(scene):
	credits_rolling = false
	curr_scene.visible = false
	curr_scene = scene
	curr_scene.visible = true
	
func _process(delta: float) -> void:
	if curr_scene == $Creditos:
		if not credits_rolling:
			await get_tree().create_timer(1).timeout
			credits_rolling = true
		if not credits_rolling:
			return
		if $Creditos/CreditosSubindo/LogoMood.global_position.y >= 200:
			var scroll_speed = 30
			if Input.is_action_pressed("ui_accept"):
				scroll_speed = 180
			creditos_text.global_position.y -= delta*scroll_speed
		else:
			credits_rolling = false

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
	creditos_text.global_position = credits_initial_pos
	change_screen($Creditos)

func _on_sair_pressed():
	await get_tree().create_timer(0.6).timeout
	get_tree().quit()

func _on_voltar_pressed() -> void:
	change_screen($Main)
