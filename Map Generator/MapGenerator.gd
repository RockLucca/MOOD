class_name MapGenerator
extends Node2D

@onready var _father = get_parent()
@export_file("*.tscn") var ground_scane: String = "res://Map Generator/ground.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Map.tile_set.get_tiles_ids())
	for cellCoordinate in $Map.get_used_cells(0):
		var cell = $Map.get_cell_alternative_tile(0, cellCoordinate)
		print(cellCoordinate, $Map.tile_set.get_source(cell))
	
