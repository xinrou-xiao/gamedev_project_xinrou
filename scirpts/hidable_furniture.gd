extends Node

class_name HidableFurnitures

var hiding = false
var furniture = null

func interact(body: Node2D) -> void:
	if body.is_in_group("player"):
		if hiding:
			get_out(body)
		else:
			hide(body)		
	
func hide(body: Node2D):
	hiding = true
	body.hide()
	furniture.play("hide")
	await furniture.animation_finished
	
func get_out(body: Node2D):
	hiding = false
	body.show()
	furniture.play("default")
