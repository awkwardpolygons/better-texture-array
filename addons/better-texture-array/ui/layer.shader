shader_type canvas_item;

uniform sampler2DArray texarr : hint_black;
uniform float idx = 0;

void fragment() {
	COLOR = texture(texarr, vec3(UV, idx));
}