varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 uColorKey;

void main()
{
	vec4 pixelColor = texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Alpha-test first:
	if (pixelColor.a < 0.5)
		discard;
	
	// Perform key test:
	vec3 l_keyDelta = pixelColor.rgb - uColorKey.rgb;
	if (length(l_keyDelta) > 0.01)
		discard;
	
	// Output original color
    gl_FragColor = pixelColor * vec4(v_vColour.rgb, 1.0);
}
