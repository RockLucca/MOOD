extends CanvasLayer

var time_since_last_shot = 0.0
var fire_rate = 1.0

func _ready():
	$Weapons.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	$Weapons.play(Global.current_weapon + "_idle")
	$Weapons.play(Global.current_weapon + "_icon")
	print(Global.current_weapon + "_ammo")

func _process(delta):
	time_since_last_shot += delta
	var can_shoot = time_since_last_shot >= (1.0 / fire_rate)
	
	#Change to chainsaw if player is out of ammo
	if Global.current_weapon != "chainsaw" and Global.ammo <= 0:
		Global.current_weapon = "chainsaw"
		$Weapons.play("chainsaw_idle")
		$Weapons.play("chainsaw_icon")
	
	#Shoot control
	if Input.is_action_just_pressed("shoot") and can_shoot:
		if Global.current_weapon == "chainsaw":
			$Weapons.play(Global.current_weapon + "_attack")
		
		time_since_last_shot = 0.0
		if Global.current_weapon != "chainsaw":
			if Global.ammo > 0:
				Global.ammo -= 1
			#update_ammo_label(Global.current_weapon)
	
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

func update_score_label():
	$SCORE.text = str(Global.player_score)

func update_ammo_label(gun):
	#var ammo =
	#if gun == 'pistol' and ammo > 0:
		#Global.pistol_ammo -= 1
		$Ammo_value.text = str(Global.pistol_ammo)

func change_weapon():
	if Input.is_action_just_pressed("set_chainsaw"):
		Global.current_weapon = "chainsaw"
	elif Input.is_action_just_pressed("set_pistol"):
		Global.current_weapon = "pistol"
	elif Input.is_action_just_pressed("set_shotgun"):
		Global.current_weapon = "shotgun"
	elif Input.is_action_just_pressed("set_minigun"):
		Global.current_weapon = "minigun"
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
