# This class scans the scene to and connects signals from UI elements to audio stream playrs it creates
# This is easy and efficient, unlike replacing every UI element and creating dozens of AudioStreamPlayer nodes

#Esse código foi feito por Liblast e modificado para este projeto
#Está disponivel em: https://codeberg.org/Liblast/Liblast/src/commit/830727eb35ceb3d88fa72abd03b9db282d9a5ad9/Game/Assets/UI/UiSounds.gd
extends Node

@export var root_path : NodePath

# create audio player instances
@onready var sounds = {
	&"UI_Click" : AudioStreamPlayer.new(),
	&"UI_Hover" : AudioStreamPlayer.new()
	}

func _ready() -> void:
	assert(root_path != null, "Empty root path for UI Sounds!")

	# set up audio stream players and load sound files
	for i in sounds.keys():
		sounds[i].stream = load("res://Sounds/SFX/Interface/" + str(i) + ".ogg")
		# assign output mixer bus
		sounds[i].bus = &"UI"
		# add them to the scene tree
		add_child(sounds[i])

	# connect signals to the method that plays the sounds
	install_sounds(get_node(root_path))

func install_sounds(node: Node) -> void:
	for i in node.get_children():
		print(i)
		if i is Button:
			i.mouse_entered.connect(ui_sfx_play.bind(&"UI_Hover"))
			i.pressed.connect(ui_sfx_play.bind(&"UI_Click"))
		# recursion
		install_sounds(i)


func ui_sfx_play(sound : String) -> void:
	print(is_inside_tree())
	printt("Playing sound:", sound)
	sounds[sound].play()
