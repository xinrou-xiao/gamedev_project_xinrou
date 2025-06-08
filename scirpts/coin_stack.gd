extends Area2D

const MONEY_AMOUNT = 5
const WEIGHT = 0.005
signal money_stack_collected
@onready var sripte = $Sprite2D
@export var texture_path = "res://assets/target/sprite_2.png"

func _ready():
	sripte.texture = TextrueCache.get_texture(texture_path)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.set_target(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.clear_target(self)
		
func interact(body: Node2D):
	queue_free()
	body.addWeight(WEIGHT)
	body.addMoney(MONEY_AMOUNT)
	body.play_grab()
	Global.money_count = Global.money_count + MONEY_AMOUNT
	emit_signal("money_stack_collected")
