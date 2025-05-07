extends Node2D

var current_floor: int = 1
@onready var floors = $Floors
@onready var NPC = $Floors/Floor1/NPCs/NPC
@onready var red_overlay = $Warning/RedOverlay
@onready var red_material = red_overlay.material

func  _physics_process(delta: float) -> void:
	if NPC.current_state == NPC.States.CHASE:
		flash_red_alert()

func load_scene():
	var floor_scene = Floor_manager.get_floor(current_floor + 1)
	if floor_scene != null:
		floors.add_child(floor_scene)
		Floor_manager.clear_floor(current_floor)
		current_floor = current_floor + 1
	else:
		get_tree().change_scene_to_file("res://scenes/won.tscn")
	

func _on_elavator_go_up() -> void:
	load_scene()

func flash_red_alert():
	red_overlay.visible = true
	var tween = create_tween()
	red_material.set_shader_parameter("intensity", 0.5)
	tween.tween_property(red_material, "shader_parameter/intensity", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	red_overlay.visible = false
