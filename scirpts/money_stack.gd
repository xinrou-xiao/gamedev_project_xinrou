extends Area2D

const money_amount = 10

signal money_stack_collected
@onready var sripte = $Sprite2D
@export var texture_path = "res://assets/target/sprite_4.png"



func _ready():
	sripte.texture = TextrueCache.get_texture(texture_path)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.set_target(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.clear_target()
		
func interact(body: Node2D):
	queue_free()
	body.addMoney(money_amount)
	body.play_grab()
	emit_signal("money_stack_collected")
