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
	// Sample fuzted sprite
	vec2 validTexCoord = v_vTexcoord / v_vFutzValues.x;
    vec4 textureColor = v_vColour * texture2D( gm_BaseTexture, fract(validTexCoord) * uTexSheetCoords.zw + uTexSheetCoords.xy );
	
	// Do alphatesting
	if (textureColor.a < 0.5)
		discard;
		
	// Do simple normal-based lighting
	float lightBrightness = dot(normalize(v_vNormal), vec3(0, 0, -1));
	vec3 lightColor = vec3(1.0, 1.0, 1.0) * mix(lightBrightness, 1.0, 0.9);
	
	gl_FragColor.rgb = textureColor.rgb * lightColor;
	gl_FragColor.a = 1.0;
}
