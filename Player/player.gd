extends CharacterBody3D

#Variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") 

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5

#Gun Variables
const _bullet_hole_res = preload("res://Sprites/Weapons/Bullet/bullet_hole.tscn")
const _chainsaw_cut_res = preload("res://Sprites/Weapons/Bullet/chainsaw_cut.tscn")
const _blood_partile_res = preload("res://Particles/blood_particle.tscn")

#Functions
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	add_to_group("Player")

func rotate_camera(dir_vector: Vector2):
	#dir_vector = dir_vector.normalized()
	#rotate_y(-dir_vector.x * Global.mouse_sensitivity/100)
	#$Pivot.rotate_x(-dir_vector.y * Global.mouse_sensitivity/100)
	rotate_y(deg_to_rad(-dir_vector.x * Global.mouse_sensitivity/100))
	$Pivot.rotate_x(deg_to_rad(-dir_vector.y * Global.mouse_sensitivity/100))
	$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.5, 1.5)

func _unhandled_input(event):
	if OS.has_feature("mobile"):
		return
	if event is InputEventMouseMotion:
		rotate_camera(event.relative)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var aim_dir = Input.get_vector("ui_left2", "ui_right2", "ui_up2", "ui_down2")
	rotate_camera(aim_dir)

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * Global.boost_velocity
		velocity.z = direction.z * SPEED * Global.boost_velocity
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * Global.boost_velocity)
		velocity.z = move_toward(velocity.z, 0, SPEED * Global.boost_velocity)

	move_and_slide()

func get_pivot_global_position():
	return $Pivot.get_global_position()

func get_player_chest_position():
	return $PlayerChest.get_global_position()

func get_pivot():
	return $Pivot

func get_bullet_ignore_list():
	var ignore = []
	
	for doors in get_tree().get_nodes_in_group("DoorArea"):
		ignore.append(doors.get_rid())

	ignore.append(get_rid())

	return ignore

func shoot(gun):
	var camera3d = $Pivot/Camera3D
	# Definir a origem no meio da tela
	var origin = get_viewport().get_visible_rect().size / 2

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
		spread = Vector2(30, -PI)
		# Recoil da arma
		rotate_camera(Vector2(randf_range(-5, 5), randf_range(-5, -3)))
		damage = 0.7
	
	damage *= Global.boost_damage

	for i in range(shotsFired):
		var from = camera3d.project_ray_origin(origin)
		
		var destiny = origin
		
		var rand_ang = randf_range(0, spread.y)
		var rand_rad = randf_range(-spread.x/2 , spread.x)
		
		destiny.x += cos(rand_ang) * rand_rad
		destiny.y += sin(rand_ang) * rand_rad
		
		var to = from + camera3d.project_ray_normal(destiny) * 100
		
		
		
		var query = PhysicsRayQueryParameters3D.create(from, to, 0xFFFFFFFF, get_bullet_ignore_list())
		query.collide_with_areas = true
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		if(result):
			var hit = result.collider
			var hitPos: Vector3 = result.position
			var normal = result.normal
			
			var hitDis = hitPos.distance_to(from)
			if gun == "chainsaw" and hitDis > 2:
				return
			
			if hit.is_in_group("ignore"):
				print(hit)
				return
			
			if hit is StaticBody3D:
				var decal = _bullet_hole_res.instantiate() if gun != "chainsaw" else _chainsaw_cut_res.instantiate()
				get_tree().get_root().add_child(decal)
				decal.create_decal(hitPos, normal)
				
			elif hit.is_in_group("enemy"):
				hit.deal_damage(damage)
				var blood = _blood_partile_res.instantiate()
				get_tree().get_root().add_child(blood)
				blood.create_blood(hitPos, normal)
			else:
				print(hit)

