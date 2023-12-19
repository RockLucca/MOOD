extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var health: float = 30

func _physics_process(_delta: float) -> void:
	pass

func deal_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		queue_free()
