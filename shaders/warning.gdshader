shader_type canvas_item;
render_mode blend_mix;

uniform float intensity : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    COLOR = vec4(1.0, 0.0, 0.0, intensity);
}