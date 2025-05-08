extends Area2D

signal go_up

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.set_target(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.clear_target()

func interact(body: Node2D):
		get_tree().change_scene_to_file("res://sences/won.tscn")
		emit_signal("go_up")
