extends CanvasLayer

var time_since_last_shot = 0.0
var fire_rate = 1.0

func _ready():
	$Weapons.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	$Weapons.play(Global.current_weapon + "_idle")
	$Wepons_icons.play(Global.current_weapon + "_icon")
	$Ammo_value.text = str(Global.pistol_ammo)

func _process(delta):
	time_since_last_shot += delta
	var can_shoot = time_since_last_shot >= (1.0 / fire_rate)
	
	#Change to chainsaw if player is out of ammo
	if Global.current_weapon != "chainsaw" and Global.ammo <= 0:
		Global.current_weapon = "chainsaw"
		$Weapons.play("chainsaw_idle")
		$Wepons_icons.play("chainsaw_icon")
	
	#Shoot control
	if Input.is_action_just_pressed("shoot") and can_shoot:
		if Global.current_weapon == "chainsaw":
			$Weapons.play(Global.current_weapon + "_attack")
		
		time_since_last_shot = 0.0
		if Global.current_weapon != "chainsaw":
			update_ammo_label(Global.current_weapon) 
	
	match Global.current_weapon:
		"chainsaw":
			fire_rate = 2.0
		"pistol":
			fire_rate = 3.0
		"shotgun":
			fire_rate = 6.0
		"minigun":
			fire_rate = 10.0
		"rpg":
			fire_rate = 1.0
		"plasma":
			fire_rate = 10.0
		_:
			fire_rate = 1.0
	
	update_health_label()
	update_armor_label()
	#update_ammo_label(Global.current_weapon)
	update_face_animation(Global.player_health)
	change_weapon()


func update_health_label():
	$Health_value.text = str(Global.player_health)

func update_armor_label():
	$Armor_value.text = str(Global.player_armor)

#Update ammo values when shoot
func update_ammo_label(gun):
	var shot = false
	if gun == "pistol" and Global.pistol_ammo > 0:
		$Weapons.play(Global.current_weapon + "_attack")
		Global.pistol_ammo -= 1
		$Ammo_value.text = str(Global.pistol_ammo)
		shot = true
	elif gun == "shotgun" and Global.shotgun_ammo > 0:
		$Weapons.play(Global.current_weapon + "_attack")
		Global.shotgun_ammo -= 2
		$Ammo_value.text = str(Global.shotgun_ammo)
		shot = true
	elif gun == "minigun" and Global.minigun_ammo > 0:
		$Weapons.play(Global.current_weapon + "_attack")
		Global.minigun_ammo -= 1
		$Ammo_value.text = str(Global.minigun_ammo)
		shot = true

	if shot:
		get_tree().get_first_node_in_group("Player").shoot(gun)

#
func change_weapon():
	if Input.is_action_just_pressed("set_chainsaw"):
		Global.current_weapon = "chainsaw"
		$Ammo_value.text = str("∞")
	elif Input.is_action_just_pressed("set_pistol"):
		Global.current_weapon = "pistol"
		$Ammo_value.text = str(Global.pistol_ammo)
	elif Input.is_action_just_pressed("set_shotgun"):
		Global.current_weapon = "shotgun"
		$Ammo_value.text = str(Global.shotgun_ammo)
	elif Input.is_action_just_pressed("set_minigun"):
		Global.current_weapon = "minigun"
		$Ammo_value.text = str(Global.minigun_ammo)
		pass

func update_face_animation(health):
	var face_health = ""
	if health > 90:
		face_health = "100%"
	elif health > 75:
		face_health = "90%"
	elif health > 60:
		face_health = "75%"
	elif health > 45:
		face_health = "60%"
	elif health > 30:
		face_health = "45%"
	elif health > 15:
		face_health = "30%"
	else:
		face_health = "15%"
	$Face.play(face_health)

func _on_AnimatedSprite2D_animation_finished():
	$Weapons.play(Global.current_weapon + "_idle")
	$Wepons_icons.play(Global.current_weapon + "_icon")
