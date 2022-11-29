shader_type spatial;
uniform float strenght;

void fragment() {
	// Place fragment code here.
	ALBEDO = vec3(0.88,1.0,0.0); 
	ALPHA = strenght;
}