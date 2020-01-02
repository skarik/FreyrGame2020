//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec4 v_vWorldPosition;

// Texel size of the snow buffer
uniform vec2 uSnowTexelSize;

void main()
{
	vec4 pixelSnowDensityRaw = texture2D( gm_BaseTexture, v_vTexcoord );
	float pixelSnowDensity = pixelSnowDensityRaw.r;
	float pixelSnowHeight = pixelSnowDensityRaw.g;
	float pixelSnowNoise = pixelSnowDensityRaw.b;
	
	const vec4 kColorSnow0	= vec4(240, 250, 255, 255) / 255.0;
	const vec4 kColorSnow1	= vec4(116, 186, 234, 255) / 255.0;
	const vec4 kColorSnow2	= vec4(85, 141, 222, 255) / 255.0;
	const vec4 kColorSnow3	= vec4(107, 123, 137, 255) / 255.0;
	
	if (pixelSnowDensity < 1.0)
		discard;
	
	// Start with pristine snow
	vec4 pixelSnow = (pixelSnowNoise > 0.6) ? kColorSnow0 : kColorSnow1;
	
	// Check top ridge to see if should darken the snow
	float pixelSnowDensityUp0 = texture2D( gm_BaseTexture, v_vTexcoord - vec2(0, uSnowTexelSize.y) ).r;
	if (pixelSnowDensityUp0 < 1.0)
		pixelSnow = kColorSnow1;
		
	// Check bottom ridge to see if should darken the snow
	float pixelSnowDensityDown0 = texture2D( gm_BaseTexture, v_vTexcoord + vec2(0, uSnowTexelSize.y * 9.0 * pixelSnowHeight) ).r;
	float pixelSnowDensityDown1 = texture2D( gm_BaseTexture, v_vTexcoord + vec2(0, uSnowTexelSize.y * 6.0 * pixelSnowHeight) ).r;
	float pixelSnowDensityDown2 = texture2D( gm_BaseTexture, v_vTexcoord + vec2(0, uSnowTexelSize.y * 3.0 * pixelSnowHeight) ).r;
	if (pixelSnowDensityDown2 < 1.0)
		pixelSnow = kColorSnow3;
	else if (pixelSnowDensityDown1 < 1.0)
		pixelSnow = kColorSnow2;
	else if (pixelSnowDensityDown0 < 1.0)
		pixelSnow = kColorSnow1;
		
	// Final result
	gl_FragColor = pixelSnow;
}
