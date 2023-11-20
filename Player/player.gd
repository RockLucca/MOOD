extends CharacterBody3D

#Basic Variables
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") # Get the gravity from the project settings to be synced with RigidBody nodes.
@export var mouse_sensitivity = 0.01
@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
const _bullet_hole_res = preload("res://Sprites/Weapons/Bullet/bullet_hole.tscn")

#Functions
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

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
	if Input.is_action_just_pressed("shoot"):
		shoot(Global.current_weapon)

# Codigo de mostrar um ponto no 3D retirado desse repositorio: https://github.com/Ryan-Mirch/Line-and-Sphere-Drawing/blob/main/Draw3D.gd
func point(pos:Vector3, radius = 0.05, color = Color.WHITE_SMOKE, persist_ms = 0):
	var mesh_instance := MeshInstance3D.new()
	var sphere_mesh := SphereMesh.new()
	var material := ORMMaterial3D.new()
		
	mesh_instance.mesh = sphere_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	mesh_instance.position = pos
	
	sphere_mesh.radius = radius
	sphere_mesh.height = radius*2
	sphere_mesh.material = material
	
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	
	get_tree().get_root().add_child(mesh_instance)
	if persist_ms:
		await get_tree().create_timer(persist_ms).timeout
		mesh_instance.queue_free()
	else:
		return mesh_instance


func shoot(gun):
	var camera3d = $Pivot/Camera3D
	var origin = get_viewport().get_mouse_position()
	
	var shotsFired: int = 0
	var spread: Vector2 = Vector2.ZERO
	var damage: float = 1
	
	if gun == "pistol":
		shotsFired = 1
		spread = Vector2.ZERO
		damage = 1
	
	if gun == "12":
		shotsFired = 8
		spread = Vector2(200, 200)
		damage = 0.3

	for i in range(shotsFired):
		
		var from = 	camera3d.project_ray_origin(origin)
		
		var destiny = origin
		destiny.x += randf_range(-spread.x/2, spread.x/2)
		destiny.y += randf_range(-spread.y/2, spread.y/2)
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
				hole.create_hole(hitPos, normal)
				get_tree().get_root().add_child(hole)
			elif hit.is_in_group("enemy"):
				hit.deal_damage(damage)
			else:
				point(result.position, 0.05, Color.WHITE_SMOKE, 10)
				print(hit)

func change_gun(gun):
	pass

func _process(delta):
	pass
