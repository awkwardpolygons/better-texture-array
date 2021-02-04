shader_type canvas_item;

uniform sampler2DArray texarr : hint_black;
uniform float idx = 0;
uniform vec4 chn = vec4(1);

void fragment() {
	vec4 lyr = texture(texarr, vec3(UV, idx));
	COLOR = all(bvec4(chn)) ? lyr : vec4(dot(lyr, chn));
}