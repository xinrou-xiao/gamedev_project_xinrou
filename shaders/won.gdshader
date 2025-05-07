shader_type canvas_item;

uniform float speed = 1.0;
uniform float density = 50.0;
uniform float brightness = 1.0;

float rand(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    float time_shift = fract(TIME * speed + rand(UV * density));
    float sparkle = step(0.95, time_shift);
    vec3 snow_color = vec3(brightness) * sparkle;

    COLOR = vec4(snow_color, sparkle); 
}
