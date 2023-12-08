extends CanvasLayer

var time_since_last_shot = 0.0
var fire_rate = 1.0

func _ready():
	if not OS.has_feature("mobile"):
		$Mobile.hide()
	$Weapons.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	$Weapons.play(Global.current_weapon + "_idle")
	$Wepons_icons.play(Global.current_weapon + "_icon")
	$Label_Tags/Ammo_value.text = str(Global.pistol_ammo)

func _process(delta):
	time_since_last_shot += delta
	var can_shoot = time_since_last_shot >= (1.0 / (fire_rate * Global.boost_firerate))
	
	#Change to chainsaw if player is out of ammo
	#if Global.current_weapon != "chainsaw" and Global.ammo <= 0:
		#Global.current_weapon = "chainsaw"
		#$Weapons.play("chainsaw_idle")
		#$Wepons_icons.play("chainsaw_icon")
	
	#Shoot control
	if Input.is_action_pressed("shoot") and can_shoot:
		if Global.current_weapon == "chainsaw":
			$Weapons.play(Global.current_weapon + "_attack")
		
		time_since_last_shot = 0.0
		shoot(Global.current_weapon) 
	
	match Global.current_weapon:
		"chainsaw":
			fire_rate = 10.0
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
	
	update_ammo_label(Global.current_weapon)
	update_health_label()
	update_armor_label()
	update_face_animation(Global.player_health)
	change_weapon()


func update_health_label():
	$Label_Tags/Health_value.text = str(Global.player_health)

func update_armor_label():
	$Label_Tags/Armor_value.text = str(Global.player_armor)

func shoot(gun):
	var shot = false
	if gun == "chainsaw":
		#$Audios_Armas/Chainsaw/Chainsaw_idle.stop()
		$Audios_Armas/Chainsaw/Chainsaw_fire.play()
		shot = true
	
	if gun == "pistol" and Global.pistol_ammo > 0:
		$Weapons.play(Global.current_weapon + "_attack")
		$Audios_Armas/Pistol/Pistol_fire.play()
		Global.pistol_ammo -= 1
		Global.ammo = Global.pistol_ammo
		shot = true
	elif gun == "shotgun" and Global.shotgun_ammo > 0:
		$Weapons.play(Global.current_weapon + "_attack")
		$Audios_Armas/Shotgun/Shotgun_fire.play()
		Global.shotgun_ammo -= 2
		Global.ammo = Global.shotgun_ammo
		shot = true
	elif gun == "minigun" and Global.minigun_ammo > 0:
		$Weapons.play(Global.current_weapon + "_attack")
		$Audios_Armas/Minigun/Minigun_fire.play()
		Global.minigun_ammo -= 1
		Global.ammo = Global.minigun_ammo
		shot = true

	if shot:
		get_tree().get_first_node_in_group("Player").shoot(gun)

#Update ammo values when shoot
func update_ammo_label(gun):
	if gun == "pistol":
		$Label_Tags/Ammo_value.text = str(Global.pistol_ammo)
	elif gun == "shotgun":
		$Label_Tags/Ammo_value.text = str(Global.shotgun_ammo)
	elif gun == "minigun":
		$Label_Tags/Ammo_value.text = str(Global.minigun_ammo)

func change_weapon():
	if Input.is_action_pressed("set_chainsaw"):
		Global.current_weapon = "chainsaw"
		#$Audios_Armas/Chainsaw/Chainsaw_start.play()
		$Audios_Armas/Chainsaw/Chainsaw_idle.autoplay = true
		$Audios_Armas/Chainsaw/Chainsaw_idle.play()
		$Label_Tags/Ammo_value.text = str("∞")
	
	elif Input.is_action_just_pressed("set_pistol"):
		Global.current_weapon = "pistol"
		$Audios_Armas/Chainsaw/Chainsaw_idle.stop()
		$Label_Tags/Ammo_value.text = str(Global.pistol_ammo)
		
	elif Input.is_action_just_pressed("set_shotgun"):
		Global.current_weapon = "shotgun"
		$Audios_Armas/Chainsaw/Chainsaw_idle.stop()
		$Label_Tags/Ammo_value.text = str(Global.shotgun_ammo)
		
	elif Input.is_action_just_pressed("set_minigun"):
		Global.current_weapon = "minigun"
		$Audios_Armas/Chainsaw/Chainsaw_idle.stop()
		$Label_Tags/Ammo_value.text = str(Global.minigun_ammo)
		pass

func update_face_animation(health):
	var face_health = ""
	if health > 75:
		face_health = "100%"
	elif health > 50:
		face_health = "75%"
	elif health > 25:
		face_health = "50%"
	else:
		face_health = "25%"
	$Face.play(face_health)

func _on_AnimatedSprite2D_animation_finished():
	$Weapons.play(Global.current_weapon + "_idle")
	$Wepons_icons.play(Global.current_weapon + "_icon")

func _on_button_pressed():
	Input.action_press("Pause")
