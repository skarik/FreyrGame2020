//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vWorldPosition;

// Input needed is the 3d lut sampler
uniform sampler2D samplerPaletteLUT;
uniform sampler2D samplerPaletteLUTSecond;
uniform vec4 uLookupDivs;

//============================================================================//
// Helpers (Color):

// Returns distance between colors
float rgbDistanceSqr(vec3 colorA, vec3 colorB)
{
    vec3 delta = (colorA - colorB);
    return dot(delta, delta);
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
	//vec4 color_lookup2	= texture2D( samplerPaletteLUTSecond, color_lookup_coords );
	
	// Get the percent between the primary and secondary lookup
	//vec2 color_distances = vec2( rgbDistanceSqr(color_scene.rgb, color_lookup.rgb), rgbDistanceSqr(color_scene.rgb, color_lookup2.rgb) );
	//float percent = calculateLinearWeight(color_distances.x, color_distances.y);
	
	//color_lookup.rgb = mix(color_lookup.rgb, color_lookup2.rgb, calculateAlphaDither(percent, floor(v_vWorldPosition.xy)));
	
	//gl_FragColor = vec4(abs(color_lookup - color_scene).rgb, 1.0);
	//gl_FragColor = vec4(percent, percent, percent, 1.0);
    gl_FragColor = color_lookup;
	//gl_FragColor = v_vTexcoord.xyyy;
	//gl_FragColor = color_scene;
}
