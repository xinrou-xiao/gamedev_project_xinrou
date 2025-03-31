shader_type spatial;
varying vec3 world_vertex;

#include "util/random.gdshaderinc"
#include "util/grid.gdshaderinc"

void vertex() {
	world_vertex = (MODEL_MATRIX * vec4(VERTEX,1)).xyz;
}

void fragment() {
	ivec3 cell_coord = cell_coord_3d(world_vertex+vec3(0.001,0.001,0.001),vec3(0.01,0.01,0.01));
	uint seed = hash_ivec3(0u,cell_coord);
	//val = lcg(val);
	//ALBEDO = vec3(float(val)/float(0xFFFFFFFFu),0,0);
	ALBEDO = random_vec3(seed);
}
