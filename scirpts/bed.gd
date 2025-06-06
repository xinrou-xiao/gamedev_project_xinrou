extends HideableFurnitures

func _ready() -> void:
	furniture = $Bed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.set_target(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.clear_target(self)
