extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var health: float = 20

var _path: Array[Vector3] = []

func _physics_process(delta: float) -> void:
  #if _path.length():
    #var direction = (_path.pop_front() - global_position).normalized()
    #move_and_slide(direction * SPEED)
  pass

func set_path(target) -> void:
  pass