//
// Lighting composite shader. Unifies sh_shadowBanding and sh_bloomDrop.
//

//
// Vertex Inputs
varying vec2		v_vTexcoord;
varying vec4		v_vWorldPosition;

//
// Uniform inputs
uniform vec2		uPixelOffset;
uniform vec2		uBloomParams;

uniform sampler2D	samplerDynamicLights;
uniform sampler2D	samplerBloom;

//============================================================================//
// Helpers (Color):

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

// Returns luminosity of the inupt RGB value
float rgb2luma(vec3 color)
{
    return dot(color, vec3(0.299, 0.587, 0.114));
}

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

float stepValue (float value, float steps)
{
	//return floor(value * (steps * 0.99)) / (steps - 1.0);
	vec2 values = vec2(floor(value * (steps * 0.99)), ceil(value * (steps * 0.99))) / (steps - 1.0);
	float percent = (value - values.x) / (values.y - values.x);
	return mix(values.x, values.y, calculateAlphaDither(percent, floor(v_vWorldPosition.xy + uPixelOffset)));
}

void main()
{
	vec4	pixelScene		= texture2D( gm_BaseTexture, v_vTexcoord );
	vec4	pixelShadowing	= texture2D( samplerDynamicLights, v_vTexcoord );
	vec4	pixelBloom		= texture2D( samplerBloom, v_vTexcoord );
	vec4	pixelOutput;
	
	//
	// Bloom
	vec3	bloomHSV;
	vec3	bloomRGB;
	//vec3	bloomHSV_original;
#if 1
	bloomRGB = mix(pixelBloom.rgb * pixelScene.rgb, pixelBloom.rgb, 0.5);	// Get a world-modulated color
	bloomRGB = max(vec3(0.0, 0.0, 0.0), bloomRGB - uBloomParams.x) * uBloomParams.y;
	bloomHSV = rgb2hsv(bloomRGB);
	bloomHSV.z = stepValue(bloomHSV.z, 16.0); // dithering
	bloomRGB = hsv2rgb(bloomHSV);

	/*bloomHSV_original = rgb2hsv(bloomRGB);
	bloomRGB = pixelBloom.rgb * pixelScene.rgb * 2.0;
	bloomRGB = max(vec3(0.0, 0.0, 0.0), bloomRGB - uBloomParams.x) * uBloomParams.y;
	bloomHSV = rgb2hsv(bloomRGB);
	bloomHSV.y = (bloomHSV.y + bloomHSV_original.y) * 0.5;
	bloomHSV.z = stepValue(bloomHSV.z, 16.0); // dithering
	bloomRGB = hsv2rgb(bloomHSV);*/
#else
	bloomRGB = pixelBloom.rgb;
	bloomRGB = max(vec3(0.0, 0.0, 0.0), bloomRGB - uBloomParams.x) * uBloomParams.y;
	bloomHSV = rgb2hsv(bloomRGB);
	bloomHSV.z = stepValue(bloomHSV.z, 16.0); // dithering
	bloomRGB = hsv2rgb(bloomHSV);
#endif
	
	//
	// Lighting recalculation
	// Roughly: need to convert to HSL, step the L, then convert back to RGB
	vec3	shadowHSV;
	vec3	shadowRGB;
	shadowHSV = rgb2hsv(pixelShadowing.rgb);
	shadowHSV.z = stepValue(shadowHSV.z, 16.0); // dithering
	shadowRGB = hsv2rgb(shadowHSV);
	
	// 
	// Lighting compositing
	pixelOutput = pixelScene;
	pixelOutput.rgb *= shadowRGB;
	pixelOutput.rgb += bloomRGB;
	
	// Final output.
    gl_FragColor = pixelOutput;
}
