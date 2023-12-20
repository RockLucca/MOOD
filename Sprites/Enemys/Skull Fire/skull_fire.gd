extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var dead: bool = false
var attacking: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var health: float = 30

func _physics_process(_delta: float) -> void:
	pass
	
func attack():
	if attacking:
		print("ATTACKING")
		return
	attacking = true
	print("NOT ATTACKING")
	$AnimatedSprite3D.play("attack")
	
func idle():
	attacking = false
	$AnimatedSprite3D.play("idle")
	
func deal_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		$AnimatedSprite3D.play("death")
		$Body.disabled = true
		$CollisionShape3D2.disabled = true
		dead = true

func _on_animated_sprite_3d_animation_finished() -> void:
	if dead:
		queue_free()
	if attacking:
		idle()
