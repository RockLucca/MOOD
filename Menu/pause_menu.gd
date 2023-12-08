extends Control

#@onready var main = $"res://../"
var paused = true

#func _ready():
	#$UI/VBoxContainer/Resume.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		pause_menu()

func _on_resume_pressed():
	pause_menu()

func _on_quit_pressed():
	get_tree().quit()

func pause_menu():
	get_tree().paused = paused
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		show()
		$UI/Opcoes/CheckBox.button_pressed = Global.is_full_screen
		start_pause_menu()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		hide()
	paused = !paused

func start_pause_menu():
	$UI/Opcoes.hide()
	$UI/MainPause.show()
	$UI/MainPause/Resume.grab_focus()

func _on_opcoes_pressed():
	$UI/MainPause.hide()
	$UI/Opcoes.show()
	pass

func _on_voltar_pressed() -> void:
	start_pause_menu()


func _on_check_box_toggled(toggled_on: bool) -> void:
	Global.is_full_screen = toggled_on

	if Global.is_full_screen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_return_pressed():
	paused = false
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
