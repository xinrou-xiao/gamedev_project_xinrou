shader_type spatial;
varying vec3 world_vertex;

#include "random.gdshaderinc"

void vertex() {
	world_vertex = (MODEL_MATRIX * vec4(VERTEX,1)).xyz;
}

void fragment() {
	vec3 rounded_coordinate = floor(world_vertex*100.0+0.0001);
	uint seed = hash_ivec3(0u,ivec3(rounded_coordinate));
	//val = lcg(val);
	//ALBEDO = vec3(float(val)/float(0xFFFFFFFFu),0,0);
	ALBEDO = random_vec3(seed);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
