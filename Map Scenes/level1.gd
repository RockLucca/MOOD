extends Node3D

@onready var paused_menu = $Pause
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pause_menu()

func pause_menu():
	if paused:
		paused_menu.hide()
		Engine.time_scale = 1
	else:
		paused_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
