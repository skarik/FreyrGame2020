//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 uBloomParams;

void main()
{
	vec4 color = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	color.rgb = max(vec3(0.0, 0.0, 0.0), color.rgb - uBloomParams.x) * uBloomParams.y;
    gl_FragColor = color;
}
