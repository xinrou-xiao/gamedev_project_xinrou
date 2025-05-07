shader_type canvas_item;

uniform float time_speed = 2.0;
uniform float min_brightness = 0.6;
uniform float max_brightness = 1.4;

void fragment() {
	float t = (sin(TIME * time_speed) + 1.0) / 2.0; // 從 0 到 1
	float brightness = mix(min_brightness, max_brightness, t);

	vec4 tex_color = texture(TEXTURE, UV);
	COLOR = vec4(tex_color.rgb * brightness, tex_color.a);
}
