//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vWorldPosition;

// Texel size of the screen
uniform vec2 uBufferTexelSize;
// Current time
uniform float uCurrentTime;

// Sampler for the water color lookup.
// Input needed is the 4 color palette for the edge, deep, middle, and highlights.
uniform sampler2D samplerPaletteLUT;
uniform vec4 uPaletteLUTAtlas;
// Sampler for the water density map
uniform sampler2D samplerDensity;
uniform sampler2D samplerDensityBlurred;
// Sampler for the caustics map
uniform sampler2D samplerCaustics;
uniform vec4 uCausticsAtlas;
// Sampler for the peturb map
uniform sampler2D samplerPeturb;
uniform vec4 uPeturbAtlas;

vec2 atlasBias(vec2 coords, vec4 atlasInfo)
{
	return coords.xy * atlasInfo.zw + atlasInfo.xy;
}

void main()
{
	// Sample shoreline
	float l_densitySampleBlurred_Initial = texture2D( samplerDensityBlurred, v_vTexcoord ).g;
	
	// Generate a simple peturb map for the slight wave effect:
	vec2 l_bufferWavePeturb = vec2(0, 0);
	if (l_densitySampleBlurred_Initial > 0.01)
	{
		// Low res scroller
		l_bufferWavePeturb.y += cos(uCurrentTime * -1.1 + v_vWorldPosition.y * 0.12 - v_vWorldPosition.x * 0.03);
		// Med res scroller
		//l_bufferWavePeturb.y -= cos(uCurrentTime * -1.9 + v_vWorldPosition.y * 0.13 - v_vWorldPosition.x * 0.07);
		// High res scroller (multiplicative)
		l_bufferWavePeturb.y *= cos(uCurrentTime * +3.6 + v_vWorldPosition.y * 0.27 - v_vWorldPosition.x * 0.23);
		l_bufferWavePeturb.y *= cos(uCurrentTime * -2.8 + v_vWorldPosition.y * 0.24 - v_vWorldPosition.x * 0.17);
		// Rebias to always be positive
		//l_bufferWavePeturb = l_bufferWavePeturb * 0.25 + 0.5;
		// Limit to one pixel
		l_bufferWavePeturb *= uBufferTexelSize;
	}
	
	// Perform check against the base alpha mask.
	float l_alphaTest = texture2D( gm_BaseTexture, v_vTexcoord + l_bufferWavePeturb ).a;
	//float l_alphaTest = texture2D( samplerDensity, v_vTexcoord + l_bufferWavePeturb ).a;
	if (l_alphaTest > 0.5)
	//if (l_alphaTest < 0.5)
		discard;
		
	// Reference dirt color for showing stuff under the water:
	vec3 k_referenceDirtColor = vec3(0.573, 0.494, 0.416);
		
	// Genearte the peturb map for the slight refraction effect:
	vec2 l_bufferColorPeturb = vec2(0, 0);
	// High res scroller
	l_bufferColorPeturb.x += sin(uCurrentTime * +1.7 * 0.2 + v_vWorldPosition.x * 0.13 + v_vWorldPosition.y * 0.12);
	l_bufferColorPeturb.y += cos(uCurrentTime * -2.9 * 0.2 + v_vWorldPosition.y * 0.23 - v_vWorldPosition.x * 0.09);
	// Low res scroller
	l_bufferColorPeturb.x += sin(uCurrentTime * -0.9 + v_vWorldPosition.x * 0.09 + v_vWorldPosition.y * 0.05);
	l_bufferColorPeturb.y += cos(uCurrentTime * +1.4 + v_vWorldPosition.y * 0.14 - v_vWorldPosition.x * 0.02);
	// Limit to one pixel
	l_bufferColorPeturb *= uBufferTexelSize * 0.5;
	
	// Sample the refraction
	vec3 l_bufferColor = texture2D( gm_BaseTexture, v_vTexcoord + l_bufferColorPeturb ).rgb;
	
	// Start with the deep color
	vec3 l_waterColorDeep = texture2D( samplerPaletteLUT, atlasBias(vec2(0.50 + 0.125, 0.5), uPaletteLUTAtlas) ).rgb;
	
	// Add some caustics
	vec2 l_causticsCoords1 = v_vWorldPosition.xy / 64.0;
	vec2 l_causticsCoords2 = l_causticsCoords1.yx * 1.1;
	l_causticsCoords1 += vec2(uCurrentTime, uCurrentTime * 0.75) *- 0.20 * 0.5;
	l_causticsCoords1 += (l_bufferColorPeturb / uBufferTexelSize) / 16.0;
	l_causticsCoords2 += vec2(-uCurrentTime, uCurrentTime * 0.75) * -0.13 * 0.5;
	l_causticsCoords2 += (l_bufferColorPeturb / uBufferTexelSize) / 32.0;
	float l_causticsBrightness = texture2D( samplerCaustics, atlasBias(fract(l_causticsCoords1), uCausticsAtlas) ).b;
		l_causticsBrightness  += texture2D( samplerCaustics, atlasBias(fract(l_causticsCoords2), uCausticsAtlas) ).b;
	
	// Add caustics to the underwater bits
	vec3 l_causticsColor = vec3(0, 0, 0);
	l_causticsColor += vec3(1, 1, 1) * clamp(pow(l_causticsBrightness * 0.5, 3.0) * 3.0 - 0.4, 0.0, 1.0) * 0.25;
	l_causticsColor += vec3(1, 1, 1) * clamp(pow(l_causticsBrightness * 0.5, 3.0) * 3.0 - 2.0, 0.0, 1.0);
	
	// Create composited water color:
	//vec3 l_underwaterColor = mix(l_bufferColor, l_waterColorDeep, 0.5);
	vec3 l_underwaterColor = (l_bufferColor - k_referenceDirtColor) * 0.75 + l_waterColorDeep;
	
	// Add the caustics to the underwater colors
	l_underwaterColor += l_causticsColor * 0.65;
	
	// Grab the top water
	vec3 l_densitySample = texture2D( samplerDensity, v_vTexcoord + l_bufferWavePeturb ).rgb;
	
	// Grab the top water, blurred
	vec3 l_densitySampleBlurred = texture2D( samplerDensityBlurred, v_vTexcoord + l_bufferWavePeturb - l_bufferColorPeturb ).rgb;
	
	// Grab the edge color
	vec3 l_waterColorLite = texture2D( samplerPaletteLUT, atlasBias(vec2(0.75 + 0.125, 0.5), uPaletteLUTAtlas) ).rgb;
	
	vec4 l_topColor = vec4(l_waterColorLite, 0.0);
	// Set the top color's alpha based on the water density.
	l_topColor.a = max(l_densitySample.g, l_densitySampleBlurred.g);
	// Add white to the sharp edges.
	l_topColor.rgb = mix(l_topColor.rgb, vec3(1.0, 1.0, 1.0) * 0.9, clamp(l_topColor.a * 2.0 - 1.0, 0.0, 1.0));
	// Make the top alpha more apparent.
	l_topColor.a *= 3.0;
	// Clamp all the values
	l_topColor = clamp(l_topColor, 0.0, 1.0);
	
    gl_FragColor.rgb = mix(l_underwaterColor, l_topColor.rgb, l_topColor.a);//l_underwaterColor + l_densitySample.ggg;
	//gl_FragColor.rgb = vec3(l_bufferColorPeturb.x, l_bufferColorPeturb.y, 0.0) / uBufferTexelSize * 0.25 + 0.5;
	gl_FragColor.a = 1.0;
}
