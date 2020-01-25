//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec2 v_vTexcoordB;

uniform sampler2D samplerSceneB;

void main()
{
	if (v_vTexcoordB.x > 1.0 || v_vTexcoordB.y > 1.0 || v_vTexcoordB.x < 0.0 || v_vTexcoordB.y < 0.0)
		discard;
	
	vec4 pixelSceneA = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 pixelSceneB = texture2D( samplerSceneB, v_vTexcoordB );
	
	vec3 pixelDelta = pixelSceneA.rgb - pixelSceneB.rgb;
	float pixelDeltaSqrLength = dot(pixelDelta, pixelDelta);
	
	if (pixelDeltaSqrLength < 0.004)
		discard;
	
	gl_FragColor.rgba = pixelSceneA.rgba;
    //gl_FragColor.a = (pixelDeltaSqrLength > 0.001) ? 1.0 : 0.0;
}
