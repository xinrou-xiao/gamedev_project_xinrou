shader_type spatial;

uniform vec2 circle_center = vec2(0.5,0.5);
uniform float circle_radius = 0.5;

void vertex() {

}

void fragment() {
	vec2 offset = UV - circle_center;
	if (length(offset) < circle_radius) {
		ALBEDO = vec3(0,0,0);
	}
}
