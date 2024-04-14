shader_type canvas_item;
uniform float alpha : hint_range(0.0,1.0);

void fragment(){
	COLOR = vec4(1.0, 1.0, 1.0, alpha);
}