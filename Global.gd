extends Node

#Player settings
var mouse_sensitivity: float = 10
var is_full_screen: bool = false

#Level variables
var score = 0
var current_level = 1

#Player Stats
var player_armor: int = 100 
var player_health: int = 50

#Guns Ammo
var current_weapon = "pistol"
var chainsaw_ammo: int = 100       #1
var pistol_ammo: int = 20          #2
var shotgun_ammo: int = 14         #3
var minigun_ammo: int = 100          #4
var rpg_ammo: int = 2              #5
var plasma_ammo: int = 0           #6

var ammo = 20
var lives = 3

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		Global.is_full_screen = not Global.is_full_screen

		if Global.is_full_screen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
