extends HideableFurnitures

func _ready() -> void:
	furniture = $RestroomCabinet

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.set_target(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.clear_target(self)

func hide(body: Node2D):
	hiding = true
	body.hide()
	body.remove_from_group("outside_player")
	furniture.play("hide")
	await furniture.animation_finished
	furniture.play("default")
