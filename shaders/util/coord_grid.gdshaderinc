#ifndef UTIL_COORD_GRID
#define UTIL_COORD_GRID

#include "grid.gdshaderinc"
#include "simple_text.gdshaderinc"

vec4 coord_grid_2d (vec2 coord,int scale) {
	ivec2 cell_coord = cell_coord_2d(coord,vec2(0.1,0.1));
	vec2 inner_coord = inner_coord_2d(coord,vec2(0.1,0.1));
	if ( (cell_coord.x + cell_coord.y) % 2  == 0) {
		if (text_16x16_sample(uint(cell_coord.x),inner_coord)) {
			return vec4(0,0,0,1);
		} else {
			return vec4(1,1,1,1);
		}
	}
	return vec4(0,0,0,1);
}

#endif
