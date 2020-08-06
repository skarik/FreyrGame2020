//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vWorldPosition;

// Input needed is the 3d lut sampler
uniform sampler2D samplerPaletteLUT;
uniform sampler2D samplerPaletteLUTSecond;
uniform vec4 uLookupDivs;
uniform vec4 uOverlayMadd2;

//============================================================================//
// Helpers (Color):

// Returns distance between colors
float rgbDistanceSqr(vec3 colorA, vec3 colorB)
{
    vec3 delta = (colorA - colorB);
    return dot(delta, delta);
}

// Returns luminosity of the inupt RGB value
float rgb2luma(vec3 color)
{
    return dot(color, vec3(0.299, 0.587, 0.114));
}

// Converts input RGB to HSV (all values 0-1)
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
// Converts input HSV to RGB (all values 0-1)
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

//============================================================================//
// Helpers (Dithering):

// Performs dithering
float calculateAlphaDither (float alpha, vec2 clip_position)
{
    /*const int indexMatrix4x4[16] = int[](
        0,  8,  2,  10,
        12, 4,  14, 6,
        3,  11, 1,  9,
        15, 7,  13, 5);*/
	int indexMatrix4x4[16];
	indexMatrix4x4[0] = 0;   indexMatrix4x4[1] = 8;  indexMatrix4x4[2] = 2;   indexMatrix4x4[3] = 10;
	indexMatrix4x4[4] = 12;  indexMatrix4x4[5] = 4;  indexMatrix4x4[6] = 14;  indexMatrix4x4[7] = 6;
	indexMatrix4x4[8] = 3;   indexMatrix4x4[9] = 11; indexMatrix4x4[10] = 1;  indexMatrix4x4[11] = 9;
	indexMatrix4x4[12] = 15; indexMatrix4x4[13] = 7; indexMatrix4x4[14] = 13; indexMatrix4x4[15] = 5;

	ivec2 pixel_index = ivec2( int(clip_position.x), int(clip_position.y) );
	int index = int(mod(float(pixel_index.x), 4.0)) + int(mod(float(pixel_index.y), 4.0)) * 4;
	float index_value = float(indexMatrix4x4[index]) / 16.0 + 0.001;

	return (alpha <= index_value) ? 0.0 : 1.0;
}

//============================================================================//
// Main:

float calculateLinearWeight(float value1, float value2)
{
	const float curve = 8.0;
	if (value1 < value2)
	{
		// Closer to value1, on lower half of the curve
	    return pow(value1 / value2, curve) * 0.5;
	}
	else
	{
		// Closer to value2, on upper half of the curve
	    return 1.0 - pow(value2 / value1, curve) * 0.5;
	}
}

void main()
{
	// Sample the scene normally
	vec4 color_scene	= texture2D( gm_BaseTexture, v_vTexcoord );
	
	// Perform the 3D lookup
	vec2 color_lookup_coords = vec2(
		color_scene.r * uLookupDivs.x * (254.0/255.0) + floor(color_scene.b * uLookupDivs.z) * uLookupDivs.w,
		color_scene.g * uLookupDivs.y);
	vec4 color_lookup	= texture2D( samplerPaletteLUT, color_lookup_coords );
	vec4 color_lookup2	= texture2D( samplerPaletteLUTSecond, color_lookup_coords );
	
	// Get the percent between the primary and secondary lookup
	vec2 color_distances = vec2( rgbDistanceSqr(color_scene.rgb, color_lookup.rgb), rgbDistanceSqr(color_scene.rgb, color_lookup2.rgb) ); // breaks with nighttime overlay. needs fix. maybe do madding in shader?
	float percent = calculateLinearWeight(color_distances.x, color_distances.y);
	
	// Get original HSV of the color
	//vec3 color_original_hsv = rgb2hsv(color_scene.rgb);
	
	// Blend in-palette
	color_lookup.rgb = mix(color_lookup.rgb, color_lookup2.rgb, percent);
	
	// Push the original HSV onto the current HSV:
	/*vec3 color_lookup_hsv = rgb2hsv(color_lookup.rgb);
	// Saturate it based on the brightness - the brighter, the less the push should be.
	color_lookup_hsv.y = mix(color_lookup_hsv.y, color_original_hsv.y, 1.0 - color_lookup_hsv.z * 0.2);
	// Also push the original hue.
	color_lookup_hsv.x = mix(color_lookup_hsv.x, color_original_hsv.x, 1.0 - color_lookup_hsv.z * 0.2);
	color_lookup.rgb = hsv2rgb(color_lookup_hsv);*/
	
	//
	// Apply overlay, with constant luma
	float color_luma = rgb2luma(color_lookup.rgb);
	color_lookup.rgb *= uOverlayMadd2.rgb * 2.0;
	float color_luma_post = rgb2luma(color_lookup.rgb);
	 // Move the luma back up to the original
	color_lookup.rgb *= color_luma / color_luma_post;
	
	//
	// Apply overlay, with constant value
	/*vec3  color_hsv			= rgb2hsv(color_lookup.rgb);
	float color_luma		= rgb2luma(color_lookup.rgb);
	color_lookup.rgb *= uOverlayMadd2.rgb * 2.0;
	vec3  color_hsv_post	= rgb2hsv(color_lookup.rgb);
	float color_luma_post	= rgb2luma(color_lookup.rgb);
	// Bump up saturation if the luma difference is making it brighter
	//color_hsv_post.y = mix(color_hsv_post.y, 1.0, clamp(color_luma - color_luma_post, 0.0, 1.0));
	//color_hsv_post.y = mix(color_hsv_post.y, 1.0, clamp(color_hsv.z - color_hsv_post.z, 0.0, 1.0));
	// Bump up the value
	//color_hsv_post.z *= (color_luma / color_luma_post);
	color_hsv_post.z = color_hsv.z;
	color_lookup.rgb = hsv2rgb(color_hsv_post);*/
	
	// Dither-step alpha
	float stepped_alpha_upper = ceil(color_scene.a * 4.0) / 4.0;
	float stepped_alpha_lower = floor(color_scene.a * 4.0) / 4.0;
	float percent_alpha = (color_scene.a - stepped_alpha_lower) * 4.0; // (upper - lower) = 0.25, so multiply by (1/0.25)
	float stepped_alpha = mix(stepped_alpha_lower, stepped_alpha_upper, calculateAlphaDither(percent_alpha, floor(v_vWorldPosition.xy)));
	
    gl_FragColor.rgb = color_lookup.rgb;
	gl_FragColor.a = stepped_alpha;
}
