extends CanvasLayer

var time_since_last_shot = 0.0
var fire_rate = 1.0

func _ready():
	$Weapons.animation_finished.connect(_on_AnimatedSprite2D_animation_finished)
	$Weapons.play(Global.current_weapon + "_idle")
	$Weapons.play(Global.current_weapon + "_icon")

func _process(delta):
	time_since_last_shot += delta
	var can_shoot = time_since_last_shot >= (1.0 / fire_rate)
	
	if Global.current_weapon != "chainsaw" and Global.ammo <= 0:
		Global.current_weapon = "chainsaw"
		$Weapons.play("chainsaw_idle")
		$Weapons.play("chainsaw_icon")
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		
		if Global.current_weapon == "chainsaw":
			$Weapons.play("chainsaw_attack")
		else:
			$Weapons.play(Global.current_weapon + "_attack")
			
		time_since_last_shot = 0.0
		
		if Global.current_weapon != "chainsaw":
			if Global.ammo > 0:
				Global.ammo -= 1
	
	match Global.current_weapon:
		"pistol":
			fire_rate = 3.0
		"shotgun":
			fire_rate = 6.0
		"minigun":
			fire_rate = 10.0
		"chainsaw":
			fire_rate = 2.0
		_:
			fire_rate = 1.0
	
	update_health_label()
	update_armor_label()
	update_ammo_label()


func update_health_label():
	$Healf_value.text = str(Global.player_health)

func update_armor_label():
	$Armor_value.text = str(Global.player_armor)

func update_score_label():
	$SCORE.text = str(Global.player_score)

func update_ammo_label():
	$Ammo_value.text = str(Global.ammo)

func _on_AnimatedSprite2D_animation_finished():
	$Weapons.play(Global.current_weapon + "_idle")
	$Weapons.play(Global.current_weapon + "_icon")
