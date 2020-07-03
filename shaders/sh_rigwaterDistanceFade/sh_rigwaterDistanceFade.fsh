//
// Simple passthrough fragment shader
//
varying vec4 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vFutzValues;
varying vec3 v_vNormal;
varying vec4 v_vWorldPosition;

uniform vec4 uTexSheetCoords;

void main()
{
	vec3 kFadeColorShadow = vec3(0.094, 0.247, 0.224);
	vec3 kFadeColorWater = vec3(0.153, 0.392, 0.408);
	vec3 kFadeColorSky = vec3(0.333, 0.553, 0.871);
	
	// Sample fuzted sprite
	vec2 validTexCoord = v_vTexcoord / v_vFutzValues.x;
    vec4 textureColor = v_vColour * texture2D( gm_BaseTexture, fract(validTexCoord) * uTexSheetCoords.zw + uTexSheetCoords.xy );
	
	vec4 waterColor = textureColor;
	// Fade the water in the distance
	waterColor.rgb = mix(waterColor.rgb, kFadeColorWater, clamp((v_vWorldPosition.w - 50.0) / 200.0, 0.0, 1.0));
	// Fade the water when below 0
	waterColor.rgb = mix(waterColor.rgb, kFadeColorShadow, clamp(-v_vWorldPosition.z * 0.3, 0.0, 1.0));
	// Fade to sky in the distance
	waterColor.rgb = mix(waterColor.rgb, kFadeColorSky, clamp((v_vWorldPosition.w - 150.0) / 400.0, 0.0, 1.0));
	
	// Do alphatesting
	if (textureColor.a < 0.5)
		discard;
		
	// Do simple normal-based lighting
	float lightBrightness = dot(normalize(v_vNormal), vec3(0, 0, -1));
	vec3 lightColor = vec3(1.0, 1.0, 1.0) * mix(lightBrightness, 1.0, 0.9);
	
	gl_FragColor.rgb = waterColor.rgb * lightColor;
	gl_FragColor.a = 1.0;
}
