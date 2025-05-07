extends ColorRect

@onready var dissolve_pattern: Texture2D
@onready var dissolve_material: ShaderMaterial

var dissolve_state = 0.0
var dissolve_speed = 0.1

func _ready():
	dissolve_material.set_shader_parameter("dissolve_pattern", dissolve_pattern)
	dissolve_material.set_shader_parameter("dissolve_state", dissolve_state)

func _process(delta):
	if dissolve_state < 1.0:
		dissolve_state += dissolve_speed * delta
		dissolve_material.set_shader_parameter("dissolve_state", dissolve_state)
