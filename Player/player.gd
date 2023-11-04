extends CharacterBody3D

#Consts
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

#Basic Variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") # Get the gravity from the project settings to be synced with RigidBody nodes.

#Gun Variables


#Functions
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

"""
var max_speed = 8
var mouse_sensitivity = 0.002

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("move_forwards"):
			input_dir += -global_transform.basis.z
	
	if Input.is_action_pressed("move_backwards"):
		input_dir += global_transform.basis.z
	
	if Input.is_action_pressed("move_left"):
		input_dir += -global_transform.basis.x
		
		if Input.is_action_pressed("move_right"):
			input_dir += global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir


func _physics_process(delta):
	velocity += gravity * delta
	var desired_velocity = get_input() * max_speed
	velocity.x = desired_velocity.x
	velocity.x = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
"""

func _unhandled_input(event):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func change_gun(gun):
	pass

func _process(delta):
	pass
