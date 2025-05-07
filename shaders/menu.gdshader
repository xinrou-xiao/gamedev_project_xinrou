shader_type canvas_item;

uniform vec4 base_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); 
uniform float speed = 2.0;

void fragment() {
    float wave = sin(TIME * speed + UV.x * 20.0) * 0.1;
    COLOR = base_color + vec4(wave, wave, wave, 0.0);
}