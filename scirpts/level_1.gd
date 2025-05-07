extends Node2D

signal money_collected


func _on_money_stack_collected() -> void:
	emit_signal("money_collected")
