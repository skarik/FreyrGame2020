//
// Simple passthrough fragment shader
//
varying vec4 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vFutzValues;
varying vec3 v_vNormal;

uniform vec4 uTexSheetCoords;

void main()
{
	vec2 validTexCoord = v_vTexcoord / v_vFutzValues.x;
    vec4 textureColor = v_vColour * texture2D( gm_BaseTexture,  validTexCoord * uTexSheetCoords.zw + uTexSheetCoords.xy );
	
	// Get rid of the transparent areas
	if (textureColor.a < 0.5)
		discard;
		
	float lightBrightness = dot(v_vNormal, vec3(0, 0, -1));
	vec3 lightColor = vec3(1.0, 1.0, 1.0) * lightBrightness;
	
	gl_FragColor.rgb = textureColor.rgb * lightColor;
	gl_FragColor.a = 1.0;
}
