extends Node
class_name InteractionFacade

var current_target: Node = null

func set_target(target: Node) -> void:
	current_target = target

func clear_target() -> void:
	current_target = null

func interact(body: Node2D) -> void:
	if current_target and current_target.has_method("interact"):
		current_target.interact(body)
