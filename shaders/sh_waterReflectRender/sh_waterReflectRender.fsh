//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
//varying vec4 v_vColour;
varying vec4 v_vWorldPosition;

// Current time
uniform float uCurrentTime;

uniform sampler2D samplerWaterMask;
uniform sampler2D samplerDepthHack;

void main()
{
	vec2 l_vFlippedCoord = v_vTexcoord;
	l_vFlippedCoord.y = 1.0 - l_vFlippedCoord.y;
	
	// Discard any non-water areas
	vec4 l_waterMask = texture2D( samplerWaterMask, l_vFlippedCoord );
	if (l_waterMask.a < 0.5)
		discard;

	// Sample the fake depth
	vec4 l_waterFakeDepth = texture2D( samplerDepthHack, v_vTexcoord );
	
	// Peturb the reflection based on the depth:
	vec2 l_vPeturbedCoord = v_vTexcoord;
	float l_peturbStrength = 1.0 - l_waterFakeDepth.r;
	l_peturbStrength += (1.0 - l_waterMask.r) * 0.1;
	l_peturbStrength *= (3.0 / 640.0);
	l_vPeturbedCoord.x += l_peturbStrength * sin(v_vWorldPosition.y * 2.14 + uCurrentTime * 2.12 * 2.0);
	l_vPeturbedCoord.x += l_peturbStrength * cos(v_vWorldPosition.y * -3.64 - uCurrentTime * 1.12 * 3.0);
	l_vPeturbedCoord.x += l_peturbStrength * sin(v_vWorldPosition.y * 4.53 - uCurrentTime * 1.77 * 4.0);
	
	// Sample the peturbed reflection
	vec4 l_waterReflection = texture2D( gm_BaseTexture, l_vPeturbedCoord );
	
	// Fade out with depth
	float l_alphaWhack = l_waterFakeDepth.r * 0.6 + pow(l_waterFakeDepth.r, 5.0) * 0.5;
	l_alphaWhack += length(l_waterReflection.rgb) * 0.25; // Brighten with light colors
	//l_alphaWhack *= // Remove shoreline
	// Clamp the alphawhat
	l_alphaWhack = clamp(l_alphaWhack, 0.0, 1.0);
	
	// Apply the alpha whacking.
	l_waterReflection.a *= l_alphaWhack;
	
	gl_FragColor = l_waterReflection;
}
