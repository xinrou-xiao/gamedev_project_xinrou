shader_type spatial;

#include "res://shaders/util/coord_grid.gdshaderinc"

uniform int step_index = 0;
uniform vec2 circle_center = vec2(0.5,0.5);
uniform float circle_radius = 0.5;

void vertex() {

}

void fragment() {
	if (step_index >= 0){
		ALBEDO = coord_grid_2d(UV.xy,0).rgb;
	}
	vec2 offset = UV - circle_center;
	if (step_index >= 1) {
		ALBEDO.xy = offset.xy;
	}
	float offset_length = length(offset);
	if (step_index >= 2) {
		ALBEDO.xyz = vec3(offset_length);
	}
	if (step_index >= 3) {
		if (length(offset) < circle_radius) {
			ALBEDO = vec3(0,0,0);
		} else {
			ALBEDO = vec3(1,1,1);
		}
	}
}
