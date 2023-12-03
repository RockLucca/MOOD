extends CharacterBody3D

#Variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") # Get the gravity from the project settings to be synced with RigidBody nodes.
@export var mouse_sensitivity = 0.01
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

#Gun Variables
const _bullet_hole_res = preload("res://Sprites/Weapons/Bullet/bullet_hole.tscn")
const _blood_partile_res = preload("res://Particles/blood_particle.tscn")

#Functions
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("Player")

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.5, 1.5)
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		print(event.position)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func shoot(gun):
	var camera3d = $Pivot/Camera3D
	var origin = get_viewport().get_mouse_position()
	
	var shotsFired: int = 0
	var spread: Vector2 = Vector2.ZERO
	var damage: float = 1
	
	if gun == "chainsaw":
		shotsFired = 1
		spread = Vector2.ZERO
		damage = 1.0
	
	if gun == "pistol":
		shotsFired = 1
		spread = Vector2.ZERO
		damage = 1.0
	
	if gun == "shotgun":
		shotsFired = 8
		spread = Vector2(100, 2*PI)
		damage = 1.3
	
	if gun == "minigun":
		shotsFired = 1
		spread = Vector2.ZERO
		damage = 0.7


	for i in range(shotsFired):
		var from = camera3d.project_ray_origin(origin)
		
		var destiny = origin
		
		var rand_ang = randf_range(0, spread.y)
		var rand_rad = randf_range(-spread.x/2 , spread.x)
		
		destiny.x += cos(rand_ang) * rand_rad
		destiny.y += sin(rand_ang) * rand_rad
		
		var to = from + camera3d.project_ray_normal(destiny) * 100
		
		var query = PhysicsRayQueryParameters3D.create(from, to, 0xFFFFFFFF, [get_rid()])
		query.collide_with_areas = true
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		
		if(result):
			var hit = result.collider
			var hitPos = result.position
			var normal = result.normal
			
			if hit is StaticBody3D:
				var hole = _bullet_hole_res.instantiate()
				get_tree().get_root().add_child(hole)
				hole.create_hole(hitPos, normal)
				
			elif hit.is_in_group("enemy"):
				hit.deal_damage(damage)
				var blood = _blood_partile_res.instantiate()
				get_tree().get_root().add_child(blood)
				blood.create_blood(hitPos, normal)
				
			else:
				print(hit)

