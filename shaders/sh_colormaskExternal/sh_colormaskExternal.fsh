//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 uMultipliedColor;

void main()
{
	float alpha = texture2D( gm_BaseTexture, v_vTexcoord ).a;
    gl_FragColor = vec4(v_vColour.rgb, v_vColour.a * alpha) * uMultipliedColor;
}
