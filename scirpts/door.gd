extends Node2D

@onready var door = $Sprite2D
@onready var collision = $Sprite2D/StaticBody2D/CollisionShape2D
@export var door_clsoed = "res://assets/furnitures/furnitures-32.png"
@export var door_opened = "res://assets/furnitures/furnitures-33.png"
var is_open = false

func _ready() -> void:
	door.texture = TextrueCache.get_texture(door_clsoed)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.set_target(self)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		InteractableFacade.clear_target(self)

func interact(body: Node2D) -> void:
	if is_open:
		door.texture = TextrueCache.get_texture(door_clsoed)
		collision.disabled = false
	else: 
		door.texture = TextrueCache.get_texture(door_opened)
		collision.disabled = true
	is_open = !is_open
