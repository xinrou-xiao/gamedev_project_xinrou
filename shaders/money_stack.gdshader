shader_type canvas_item;

uniform float shine_speed : hint_range(0.1, 5.0) = 1; 
uniform float shine_width : hint_range(0.01, 0.5) = 0.2;
uniform float shine_intensity : hint_range(0.1, 2.0) = 0.5; 
uniform float edge_glow : hint_range(0.0, 0.5) = 0.5;
uniform vec4 shine_color : source_color = vec4(1.0, 1.0, 1.0, 0.3);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    float shine_pos = mod(TIME * shine_speed, 1.0 + shine_width) - shine_width;
    float shine = smoothstep(shine_pos, shine_pos + shine_width, UV.x);
    float edge = smoothstep(0.0, edge_glow, UV.x) * smoothstep(1.0, 1.0 - edge_glow, UV.x);
    float highlight = (shine * shine_intensity) + (edge * 0.5);
    
    COLOR = tex_color;
    COLOR.rgb = mix(COLOR.rgb, shine_color.rgb, highlight * shine_color.a);
}