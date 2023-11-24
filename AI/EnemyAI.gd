extends Node3D
# Pode ser pos1, pos2, player e none
# none = sem IA

@export var enemy_scene: PackedScene
@export var player_agro_distance = 0
@export var arrive_at_target_distance = 1
@export var enemy_speed = 0

var _current_target_idx = 0
var _current_target
var _targets
var _enemy


func _ready():
	assert(enemy_scene, "Obrigado definir cena com inimigo")
	_enemy  = enemy_scene.instantiate()
	_enemy.global_position = get_global_position()
	get_tree().get_root().add_child(_enemy)
	_targets = $Targets.get_children()
	_current_target = _targets[0] if len(_targets) else self

func _physics_process(delta: float) -> void:
	if not _enemy:
		queue_free()
		return
	
	if _current_target == self:
		return
	
	set_target()
	_enemy.velocity = (_current_target.get_global_position() - _enemy.get_global_position()).normalized() * enemy_speed
	
	_enemy.move_and_slide()

func set_target():
	var player = get_tree().get_first_node_in_group("Player")
	
	var player_pos = player.get_global_position() if player else get_global_position()
	var enemy_pos = _enemy.get_global_position()
	var current_agro = _current_target
	var current_target_pos = _current_target.get_global_position()
	
	
	_current_target = _targets[_current_target_idx]
	
	# Logica de pegar o agro do player
	if enemy_pos.distance_to(player_pos) < player_agro_distance:
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(enemy_pos, player_pos)
		var result = space_state.intersect_ray(query).collider
		
		if(result == player):
			_current_target = player
			return
	
	# Logica perdeu o agro do player => ir para o ponto de patrulha mais proximo
	if current_agro == player:
		var closest_idx = 0
		var distance = enemy_pos.distance_to(_targets[closest_idx].get_global_position())
		for target_idx in _targets.size():
			var target = _targets[target_idx]
			var distanceToThisTarget = enemy_pos.distance_to(target.get_global_position())
			if distanceToThisTarget < distance:
				distance = distanceToThisTarget
				closest_idx = target_idx
		_current_target = _targets[closest_idx]
		_current_target_idx = closest_idx
		
	# Ir para o proximo local de patrulha
	if enemy_pos.distance_to(current_target_pos) < arrive_at_target_distance:
		_current_target_idx += 1
		_current_target_idx = _current_target_idx % len(_targets)
		_current_target = _targets[_current_target_idx]

	#if(player and self.get_global_position().distance_to(player.get_global_position()) < 3):
	#	_target = player
	#	_current_move_target = 'player'