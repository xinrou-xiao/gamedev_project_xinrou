extends Control

@onready var particles = $MoneyParticles
@onready var restart_button = $BackToMenu

func _on_button_pressed() -> void:
	particles.emitting = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _ready():
	particles.emitting = false
	show_win()

func show_win():
	modulate = Color.TRANSPARENT
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate", Color.WHITE, 0.8)
	
	tween.tween_callback(func(): 
		particles.emitting = true
	).set_delay(0.3)
