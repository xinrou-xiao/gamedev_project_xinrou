class_name FloorManager
extends Node

var _floors: Dictionary = {}

func get_floor(floor_number: int) -> Node:
	if !_floors.has(floor_number):
		var scene_path = "res://scenes/floors/level%d.tscn" % floor_number
		
		var scene = load(scene_path)
		if scene:
			_floors[floor_number] = scene.instantiate()
			return _floors[floor_number]
		else:
			return null
	return _floors[floor_number]

func clear_floor(floor_number: int) -> void:
	if _floors.has(floor_number):
		_floors[floor_number].queue_free()
		_floors.erase(floor_number)
