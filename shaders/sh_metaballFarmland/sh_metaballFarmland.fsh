//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vWorldPosition;

// Input needed is the 4 color palette for the edge, deep, middle, and highlights.
uniform sampler2D samplerPaletteLUT;
uniform vec4 uPaletteAtlasCoords;
// Texel size of the screen
uniform vec2 uWaterTexelSize;
// Current time
uniform float uCurrentTime;

// Sampler for the peturb map
uniform sampler2D samplerPeturb;

void main()
{
	// Round coords
	vec4 l_worldPosition = floor(v_vWorldPosition);
	// Sample the dirt peturbation texture
	vec4 l_peturbation = texture2D( samplerPeturb, fract(l_worldPosition.xy / 30.0) );
	l_peturbation = (l_peturbation - 0.5) * 2.0; // Uncompress it.
	
	// Sample peturbed metaballs.
    vec4 l_pixelMetaball = texture2D( gm_BaseTexture, v_vTexcoord + (l_peturbation.xy - 0.5) * uWaterTexelSize );
	
	// Use red to line up the metaball look
	l_pixelMetaball.a *= l_pixelMetaball.r;
	// Apply the farmland mask (blue channel)
	l_pixelMetaball.a *= l_pixelMetaball.b;
	// Clamp alpha
	l_pixelMetaball = clamp(l_pixelMetaball, 0.0, 1.0);
	
	// Perform alpha-test discard.
	if (l_pixelMetaball.a < 0.01)
		discard;

	// Start with the solid water color
	float l_pixelPaletteSelector = 0.0;
	
	// If we're green, we're wet!
	l_pixelPaletteSelector = (l_pixelMetaball.g < 0.25) ? l_pixelPaletteSelector : 0.5;
	
	// Create edge peturbation
	float l_edgePush1 = 1.0 + max(0.0, l_peturbation.x) * 2.0; //sin(l_worldPosition.y / 4.0 + l_peturbation.y) * 4.0;
	float l_edgePush2 = 1.0 + max(0.0, l_peturbation.y) * 2.0; //sin(l_worldPosition.x / 4.0 + l_peturbation.x) * 4.0;
	float l_edgePush3 = 1.0 + max(0.0,-l_peturbation.x) * 2.0; //sin(l_worldPosition.y / 4.0 - l_peturbation.y) * 4.0;
	float l_edgePush4 = 1.0 + max(0.0,-l_peturbation.y) * 2.0; //sin(l_worldPosition.x / 4.0 - l_peturbation.x) * 4.0;
	// Check if on edge
	vec4 l_pixelMetaballEdge1RBA = texture2D( gm_BaseTexture, v_vTexcoord + l_edgePush1 * vec2(uWaterTexelSize.x, 0.0) );
	vec4 l_pixelMetaballEdge2RBA = texture2D( gm_BaseTexture, v_vTexcoord + l_edgePush2 * vec2(0.0, uWaterTexelSize.y) );
	vec4 l_pixelMetaballEdge3RBA = texture2D( gm_BaseTexture, v_vTexcoord - l_edgePush3 * vec2(uWaterTexelSize.x, 0.0) );
	vec4 l_pixelMetaballEdge4RBA = texture2D( gm_BaseTexture, v_vTexcoord - l_edgePush4 * vec2(0.0, uWaterTexelSize.y) );
	float l_pixelMetaballEdge1 = l_pixelMetaballEdge1RBA.r * l_pixelMetaballEdge1RBA.b * l_pixelMetaballEdge1RBA.a;
	float l_pixelMetaballEdge2 = l_pixelMetaballEdge2RBA.r * l_pixelMetaballEdge2RBA.b * l_pixelMetaballEdge2RBA.a;
	float l_pixelMetaballEdge3 = l_pixelMetaballEdge3RBA.r * l_pixelMetaballEdge3RBA.b * l_pixelMetaballEdge3RBA.a;
	float l_pixelMetaballEdge4 = l_pixelMetaballEdge4RBA.r * l_pixelMetaballEdge4RBA.b * l_pixelMetaballEdge4RBA.a;
	// If on the edge, select the edge color
	l_pixelPaletteSelector = (l_pixelMetaballEdge1 > 0.01) ? l_pixelPaletteSelector : 0.25;
	l_pixelPaletteSelector = (l_pixelMetaballEdge2 > 0.01) ? l_pixelPaletteSelector : 0.25;
	l_pixelPaletteSelector = (l_pixelMetaballEdge3 > 0.01) ? l_pixelPaletteSelector : 0.25;
	l_pixelPaletteSelector = (l_pixelMetaballEdge4 > 0.01) ? l_pixelPaletteSelector : 0.25;
	
	// Finally, select the proper color!
	gl_FragColor = texture2D(
		samplerPaletteLUT,
		vec2(l_pixelPaletteSelector + 0.125, 0.0) * uPaletteAtlasCoords.zw + uPaletteAtlasCoords.xy );
		
	//gl_FragColor = l_peturbation;
}
