shader_type canvas_item;

uniform float outline_size : hint_range(0.0, 0.1) = 0.02;
uniform vec3 gold_color1 : source_color = vec3(1.0, 0.8, 0.3);
uniform vec3 gold_color2 : source_color = vec3(0.8, 0.5, 0.1);
uniform float shine_speed : hint_range(0.1, 5.0) = 2.0;

void fragment() {
    float outline = 0.0;
    for (float x = -1.0; x <= 1.0; x += 1.0) {
        for (float y = -1.0; y <= 1.0; y += 1.0) {
            if (x == 0.0 && y == 0.0) continue;
            outline += texture(TEXTURE, UV + vec2(x,y) * outline_size).a;
        }
    }
    
    float shine = sin(TIME * shine_speed + UV.x * 5.0) * 0.5 + 0.5;
    vec3 metal = mix(gold_color1, gold_color2, shine);
    
    float alpha = texture(TEXTURE, UV).a;
    vec3 final = mix(metal, vec3(0.3, 0.2, 0.1), outline * (1.0 - alpha));
    
    COLOR = vec4(final, max(alpha, outline * 0.7));
}