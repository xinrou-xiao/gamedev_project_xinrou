shader_type canvas_item;

uniform vec4 color1 : source_color = vec4(0.1, 0.1, 0.5, 0.8);
uniform vec4 color2 : source_color = vec4(0.0, 0.7, 0.1, 0.8);
uniform float speed : hint_range(0.1, 5.0) = 1.0;
uniform float wave_intensity : hint_range(0.0, 1.0) = 0.3;

void fragment() {
    float wave = sin(TIME * speed + UV.x * 10.0) * wave_intensity;    
    vec4 gradient = mix(color1, color2, UV.y + wave);    
    float center = smoothstep(0.7, 0.0, distance(UV, vec2(0.5)));
    gradient.rgb += center * 0.3;
    COLOR = gradient;
}