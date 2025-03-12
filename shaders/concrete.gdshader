shader_type spatial;
varying vec3 world_vertex;


int blah (int seed) {
	return (seed*22695477) % 0x80000000;
}

void vertex() {
	world_vertex = (MODEL_MATRIX * vec4(VERTEX,1)).xyz;
}

void fragment() {
	vec3 rounded_coordinate = floor(world_vertex*100.0+0.0001);
	ivec3 tile_coordinate = ivec3(rounded_coordinate);
	uint seed = uint(tile_coordinate.x ^ tile_coordinate.y ^ tile_coordinate.z);
	int val = blah(int(tile_coordinate.y)) + blah(int(tile_coordinate.x));
	int val2 = blah(val);
	int val3 = blah(val2);
	//ALBEDO = vec3(float(val)/float(0xFFFFFFFFu),0,0);
	ALBEDO = vec3(float(val3%1024)/1024.0,0,0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
