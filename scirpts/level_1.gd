extends Node2D

signal money_collected
var money_scence = [preload("res://scenes/money_stack.tscn"),
					preload("res://scenes/coin_stack.tscn")]
var loc = Vector2()

func _on_money_stack_collected() -> void:
	emit_signal("money_collected")

func _ready() -> void:
	for i in range(0, 5):
		generate_money()
	
func generate_money():
	randomize()
	var pick = randi() % money_scence.size()
	loc.x = randf_range(0, 3456)
	loc.y = randf_range(200, 430)
	var scene = money_scence[pick].instantiate()
	scene.position = loc
	add_child(scene)
	scene.connect("money_stack_collected", Callable(self, "_on_money_stack_collected"))
