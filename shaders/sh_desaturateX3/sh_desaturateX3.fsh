//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	color.r = dot(vec3(0.2125, 0.7154, 0.0721), color.rgb) * 3.0;
    gl_FragColor = v_vColour * color.rrra;
}
