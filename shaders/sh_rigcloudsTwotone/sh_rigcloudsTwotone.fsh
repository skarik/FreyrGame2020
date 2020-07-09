//
// Simple passthrough fragment shader
//
varying vec4 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vFutzValues;
varying vec3 v_vNormal;

uniform vec4 uTexSheetCoords;
uniform vec4 uMultipliedColorLow;
uniform vec4 uMultipliedColorHigh;

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
	
	// Desaturate
	float desaturatedValue = dot(vec3(0.2125, 0.7154, 0.0721), textureColor.rgb) * 2.0;
	
	// Apply two-tone blending
	vec3 finalColor = mix(uMultipliedColorLow.rgb, uMultipliedColorHigh.rgb, clamp(desaturatedValue, 0.0, 1.0));
	
	gl_FragColor.rgb = finalColor.rgb * lightColor;
	gl_FragColor.a = 1.0;
}
