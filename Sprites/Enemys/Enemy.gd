extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var health: float = 30
var dead: bool = false
var attacking: bool = false

func _physics_process(_delta: float) -> void:
	pass
	
func get_aim_pos():
	print($AimHeight.get_global_position())
	return $AimHeight.get_global_position()
	
func aim():
	if attacking:
		return
	attacking = true
	$AnimatedSprite3D.play("aim")
	
func attack():
	if not attacking:
		return
	$AnimatedSprite3D.play("attack")
	
func idle():
	attacking = false
	$AnimatedSprite3D.play("idle")

func deal_damage(damage: float) -> void:
	health -= damage
	if health <= 0:
		$AnimatedSprite3D.play("death")
		$CollisionShape3D.disabled = true
		dead = true
		await get_tree().create_timer(5.0).timeout
		queue_free()

func _on_animated_sprite_3d_animation_finished() -> void:
	if attacking and not dead:
		idle()
