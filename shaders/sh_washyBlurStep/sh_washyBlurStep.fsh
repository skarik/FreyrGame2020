varying vec2 v_vTexcoord;
varying vec4 v_vWorldPosition;

// Texel size of the screen
uniform vec2 uTexelSize;
// Current time
uniform float uCurrentTime;

void main()
{
	vec2 coordTarget = v_vTexcoord;
	
	// Generate offsets for the washy effect
	/*vec2 coordOffset = vec2(sin(uCurrentTime * +3.6 + v_vWorldPosition.y * 0.27 - v_vWorldPosition.x * 0.23),
							sin(uCurrentTime * -2.8 + v_vWorldPosition.y * 0.24 - v_vWorldPosition.x * 0.17));*/
	vec2 coordOffset = vec2(sin(uCurrentTime * 2.12 + v_vWorldPosition.y * 0.125),
							sin(uCurrentTime * 3.12 + v_vWorldPosition.x * 0.125)) * 2.0;
	coordOffset += vec2(cos(uCurrentTime * 4.23 + v_vWorldPosition.x * 0.094),
						cos(uCurrentTime * 1.23 + v_vWorldPosition.y * 0.213));
	coordOffset /= 3.0;
	
	// Apply offsets to all samples
	coordTarget += coordOffset * uTexelSize * 1.4;
	
	// Final step: just sample naively.
    gl_FragColor = texture2D( gm_BaseTexture, coordTarget );
}
