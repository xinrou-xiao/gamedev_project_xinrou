extends Node2D

var current_floor: int = 1
@onready var floors = $Floors
@onready var hud = $HUD
@onready var red_overlay = $Warning/RedOverlay
@onready var red_material = red_overlay.material
@onready var transition = $Transition/ChangeScene

@onready var NPC: Node = $Floors/Floor1/NPCs/NPC

func _physics_process(delta: float) -> void:
	if NPC and NPC.current_state == "CHASE":
		flash_red_alert()

func load_scene():
	var old_floor_node = floors.get_node_or_null("Floor%d" % current_floor)

	current_floor += 1
	var floor_scene = Floor_manager.get_floor(current_floor)

	if floor_scene != null:
		transition.play()
		await transition.transition_finished
		floors.add_child(floor_scene)
		floor_scene.name = "Floor%d" % current_floor

		if old_floor_node:
			old_floor_node.queue_free()
			Floor_manager.clear_floor(current_floor - 1)

		if floor_scene.has_signal("money_collected"):
			floor_scene.connect("money_collected", Callable(hud, "_on_money_collected"))

		var new_npc = floor_scene.get_node_or_null("NPCs/NPC")
		if new_npc:
			NPC = new_npc

	else:
		if Global.money_count == Global.total_money:
			get_tree().change_scene_to_file("res://scenes/escape-perfect.tscn")
		elif Global.money_count >= Global.total_money * 0.5:
			get_tree().change_scene_to_file("res://scenes/escape-normal.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/escape-failed.tscn")

func _on_elavator_go_up() -> void:
	load_scene()

func flash_red_alert():
	red_overlay.visible = true
	var tween = create_tween()
	red_material.set_shader_parameter("intensity", 0.5)
	tween.tween_property(red_material, "shader_parameter/intensity", 0.0, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	await tween.finished
	red_overlay.visible = false
