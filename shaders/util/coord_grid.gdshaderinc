#ifndef UTIL_COORD_GRID
#define UTIL_COORD_GRID

#include "grid.gdshaderinc"
#include "simple_text.gdshaderinc"

vec4 coord_grid_2d (vec2 coord,int scale) {

	ivec2 cell_coord = cell_coord_2d(coord,vec2(1,1));
	vec2 inner_coord = inner_coord_2d(coord,vec2(1,1));
	vec2 border_dist = 0.5-abs(inner_coord-vec2(0.5,0.5));
	bool on_outline = any(lessThan(border_dist,vec2(0.01,0.01)));
	bool on_x_border = border_dist.x < 0.11;
	bool on_y_border = border_dist.y < 0.11;
	vec4 background_color = vec4(1,1,1,1);
	bool on_text = false;

	if (on_outline) {
		background_color = vec4(0,0,0,1);
	} else if (on_x_border && ! on_y_border) {
		background_color = vec4(1,0,0,1);
		vec2 readout_coord = vec2(inner_coord.y-0.11,border_dist.x/0.11);
		on_text = float_readout(999,readout_coord,8,8);
	} else if (on_y_border && ! on_x_border) {
		background_color = vec4(0,1,0,1);
		vec2 readout_coord = vec2(inner_coord.x-0.11,border_dist.y/0.11);
		on_text = float_readout(999,readout_coord,8,8);
	}

	if(on_text) {
		return vec4(0,0,0,1);
	} else {
		return background_color;
	}

}

#endif
