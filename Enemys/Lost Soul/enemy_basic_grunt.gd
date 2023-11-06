extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D

var speed = 3.0

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location =  nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = velocity.move_toward(new_velocity, .25)
	move_and_slide()


func update_target_location(target_location):
	nav_agent.target_position = target_location

"""
@onready var nav = get_tree().get_nodes_in_group("NavMesh")[0]
@onready var player = get_tree().get_nodes_in_group("Player")[0]

var path = [] #Cordenadas do inimigo ao player
	var path_index = 0 
	var speed = 3
	var health = 20
	
	func _ready():
	pass
	
	func take_damage():
		health -= dmg_amount
		if health <= 0:
			death()
			
			func _physics_process(delta):
	if path_index < path.size():
		var direction = (path[path_index] - global_transform.origin)
		if direction.length() < 1:
			path_index += 1
		else:
			move_and_slide(direction.normalized())
		else:
			find_path(player.global_transform.origin)
			
			func find_path(target):
				path = nav.get_simple_path(global_transform.origin, target)
	path_index = 0

func death():
	set_process(false)
	set_physics_process(false)
	$CollisionShape3D.disabled = true
	
func shoot():
	pass
"""
