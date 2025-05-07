shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;
uniform vec4 bg_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float edge_softness : hint_range(0.001, 0.2) = 0.05;

void fragment() {
    float left = 0.5 - progress * 0.5;
    float right = 0.5 + progress * 0.5;
    
    float mask = smoothstep(left, left + edge_softness, UV.x) * 
                (1.0 - smoothstep(right - edge_softness, right, UV.x));
    
    float visibility = step(0.001, progress) * (1.0 - step(0.999, progress));
    COLOR = mix(vec4(0.0), bg_color, (1.0 - mask) * visibility);
}