extends ColorRect

@export var duration : float = 1.0
@export var hold_time : float = 0.3

signal transition_finished

func _ready():
	material.set_shader_parameter("progress", 0.0)
	hide()

func play():
	show()
	material.set_shader_parameter("progress", 0.0)
	
	var tween = create_tween().set_parallel(false)
	
	tween.tween_property(material, "shader_parameter/progress", 0.5, duration/2)
	tween.tween_interval(hold_time)
	tween.tween_property(material, "shader_parameter/progress", 1.0, duration/2)
	
	tween.tween_callback(func(): 
		hide()
		emit_signal("transition_finished")
	)
