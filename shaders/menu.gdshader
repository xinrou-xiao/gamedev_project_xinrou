shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.3, 0.6, 1.0, 1.0);
uniform float outline_width : hint_range(0.0, 0.1) = 0.02;
uniform float glow_spread : hint_range(0.0, 0.5) = 0.1;
uniform float edge_smoothness : hint_range(0.001, 0.1) = 0.02;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    float base_alpha = tex.a;
    
    float outline = 0.0;
    for (float angle = 0.0; angle < 3.14159 * 2.0; angle += 0.785) {
        vec2 offset = vec2(cos(angle), sin(angle)) * outline_width;
        outline += texture(TEXTURE, UV + offset).a;
    }
    
    outline = smoothstep(0.1, 0.8, outline / 8.0);
    float border = outline * (1.0 - base_alpha);
    
    float glow = smoothstep(0.0, glow_spread, border);
    
    vec3 final_color = mix(tex.rgb, outline_color.rgb, glow);
    float final_alpha = max(base_alpha, glow * outline_color.a);
    
    COLOR = vec4(final_color, final_alpha);
}