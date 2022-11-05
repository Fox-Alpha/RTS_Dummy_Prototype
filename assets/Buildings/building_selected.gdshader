shader_type spatial;
uniform float strenght;

void fragment() {
	// Place fragment code here.
	//LBEDO = vec3(0.88,1.0,0.0);	// 999c34	// Yellowish
	ALBEDO = vec3(0.16, 0.71, 0.3, 0);	//2ab54c	// Greenish
	ALPHA = strenght;
}