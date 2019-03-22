//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vWorldPosition;

// Input needed is the 4 color palette for the edge, deep, middle, and highlights.
uniform sampler2D samplerPaletteLUT;
uniform vec4 uPaletteAtlasCoords;
uniform vec2 uWaterTexelSize;
uniform float uCurrentTime;

void main()
{
    vec4 l_pixelMetaball = texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Perform alpha-test discard.
	if (l_pixelMetaball.a < 0.5)
		discard;

	// Round coords
	vec4 l_worldPosition = floor(v_vWorldPosition);

	// Start with the solid water color
	float l_pixelPaletteSelector = 0.5;
	
	// Add a little bit of darker area in the middle
	float l_centerDarkness = l_pixelMetaball.r - 0.5;
	// Peturb it
	l_centerDarkness += sin(l_worldPosition.x * 0.05 + l_worldPosition.y * 0.2 + uCurrentTime * 0.5) * 0.10;
	l_centerDarkness += sin(l_worldPosition.x * -0.1 + l_worldPosition.y * 0.4 - uCurrentTime * 0.6) * 0.05;
	// Add the blue overrider
	l_centerDarkness += l_pixelMetaball.b * 0.5;
	// Select darker color if wanted
	l_pixelPaletteSelector = (l_centerDarkness < 0.0) ? l_pixelPaletteSelector : 0.25;
	
	// Add some highlights near the edges
	float l_edgeHighlights = 1.0 - abs(l_pixelMetaball.r - 0.1) / 0.05;
	// Make them less common
	l_edgeHighlights -= abs(sin(l_worldPosition.x * 0.19 + l_worldPosition.y * 0.21 + uCurrentTime * 0.7)) * 0.75;
	l_edgeHighlights -= abs(cos(l_worldPosition.x * 0.14 - l_worldPosition.y * 0.13 + uCurrentTime * 1.3)) * 0.75;
	l_edgeHighlights -=     sin(l_worldPosition.x *-0.22 + l_worldPosition.y * 0.21 + uCurrentTime * 0.2)  * 0.75;
	l_edgeHighlights -= abs(sin(l_worldPosition.x *-0.02 + l_worldPosition.y *-0.03 + uCurrentTime * 2.3)) * 0.25;
	l_edgeHighlights -= abs(cos(l_worldPosition.x * 0.03 + l_worldPosition.y * 0.02 + uCurrentTime * 2.1)) * 0.25;
	// Add the green overrider
	l_edgeHighlights += max(0.0, l_pixelMetaball.r * l_pixelMetaball.g - 0.25) * 35.0;
	// Select highlight color if wanted
	l_pixelPaletteSelector = (l_edgeHighlights < 0.0) ? l_pixelPaletteSelector : 0.75;
	
	// Add some center highlights
	float l_centerHighlights = l_centerDarkness;
	// Peturb and rarify the fuck out of it
	l_centerHighlights += (-14.0 - l_edgeHighlights) * 0.25;
	l_centerHighlights = clamp(l_centerHighlights, -1.0, +1.0);
	// Peturb it a lot
	l_centerHighlights += sin(l_worldPosition.x * 0.032 + l_worldPosition.y * 0.161 + uCurrentTime * 0.42) * 0.5;
	l_centerHighlights += sin(l_worldPosition.x *-0.073 + l_worldPosition.y * 0.212 - uCurrentTime * 0.64) * 0.5;
	l_centerHighlights += sin(l_worldPosition.x * 0.233 + l_worldPosition.y * 0.322 + uCurrentTime * 0.55) * 0.5;
	l_centerHighlights += sin(l_worldPosition.x * 0.286 - l_worldPosition.y * 0.257 - uCurrentTime * 0.45) * 0.5;
	// Rarify it
	l_centerHighlights -= 0.9;
	// Select highlight color if wanted
	l_pixelPaletteSelector = (l_centerHighlights < 0.0) ? l_pixelPaletteSelector : 0.75;
	
	// Check if on edge
	float l_pixelMetaballEdge1 = texture2D( gm_BaseTexture, v_vTexcoord + vec2(uWaterTexelSize.x, 0.0) ).a;
	float l_pixelMetaballEdge2 = texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0, uWaterTexelSize.y) ).a;
	float l_pixelMetaballEdge3 = texture2D( gm_BaseTexture, v_vTexcoord - vec2(uWaterTexelSize.x, 0.0) ).a;
	float l_pixelMetaballEdge4 = texture2D( gm_BaseTexture, v_vTexcoord - vec2(0.0, uWaterTexelSize.y) ).a;
	// If on the edge, select the edge color
	l_pixelPaletteSelector = (l_pixelMetaballEdge1 * l_pixelMetaballEdge2 * l_pixelMetaballEdge3 * l_pixelMetaballEdge4 > 0.5) ? l_pixelPaletteSelector : 0.0;
	
	// Finally, select the proper color!
	gl_FragColor = texture2D(
		samplerPaletteLUT,
		vec2(l_pixelPaletteSelector + 0.125, 0.0) * uPaletteAtlasCoords.zw + uPaletteAtlasCoords.xy );
		
	// Finally finally! Add some white highlights for shine
	float l_whiteHighlights = l_pixelMetaball.r * l_pixelMetaball.g - 0.75;
	// Add the highlights for peturbing
	l_whiteHighlights += (l_centerHighlights - 0.25) * 0.1;
	// Select white highlight of wanted
	gl_FragColor = (l_whiteHighlights < 0.0) ? gl_FragColor : vec4(1.0, 1.0, 1.0, 1.0);
	
}
