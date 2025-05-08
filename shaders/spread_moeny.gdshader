shader_type canvas_item;

uniform float shine_speed : hint_range(0.1, 5.0) = 2.0;
uniform float min_alpha : hint_range(0.1, 0.5) = 0.3;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    float pulse = sin(TIME * shine_speed) * 0.5 + 0.5;
    tex.a *= mix(min_alpha, 1.0, pulse);
    COLOR = tex;
}