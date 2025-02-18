shader_type spatial;
render_mode world_vertex_coords;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 wrld_vertex = (inverse(VIEW_MATRIX) * vec4(VERTEX, 1.0)).xyz;
	vec3 inner_coordinate = mod(wrld_vertex+0.001,1);
	ivec3 rounded_coordinate = ivec3(wrld_vertex - inner_coordinate);
	bvec3 is_even = equal(rounded_coordinate % 2,ivec3(0,0,0));
	bool total_even = (int(is_even.x)+int(is_even.y)+int(is_even.z))%2 == 0;
	if (total_even) {
		ALBEDO = vec3(0,0,0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
