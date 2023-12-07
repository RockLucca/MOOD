extends Control

#@onready var main = $"res://../"
@onready var paused_menu = $Pause
var paused = false

func _ready():
	$UI/VBoxContainer/Resume.grab_focus()

func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		pause_menu()

func _on_resume_pressed():
	#main.pause_menu()
	pass

func _on_quit_pressed():
	get_tree().quit()

func pause_menu():
	if paused:
		paused_menu.hide()
		Engine.time_scale = 1
	else:
		paused_menu.show()
		Engine.time_scale = 0
		
	paused = !paused

func _on_opcoes_pressed():
	pass
