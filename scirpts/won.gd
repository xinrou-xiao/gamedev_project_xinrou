extends Control

@onready var particles = $MoneyParticles
@onready var restart_button = $BackToMenu
@onready var sprite = $AnimatedSprite2D
@onready var tween = get_tree().create_tween()

func _on_button_pressed() -> void:
	particles.emitting = false
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _ready():
	particles.emitting = false
	show_win()
	start_bobbing()

func show_win():
	modulate = Color.TRANSPARENT
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate", Color.WHITE, 0.8)
	
	tween.tween_callback(func(): 
		particles.emitting = true
	).set_delay(0.3)
	
func start_bobbing():
	var original_y = sprite.position.y
	tween.set_loops() 
	tween.tween_property(sprite, "position:y", original_y - 10, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "position:y", original_y + 10, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(sprite, "position:y", original_y, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
