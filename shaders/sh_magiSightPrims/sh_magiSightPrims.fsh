//
// Dithered magisight shader
//
varying vec4 v_vColour;
varying vec4 v_vWorldCoord;

void main()
{
	ivec2 pixelIndex = ivec2( int(v_vWorldCoord.x), int(v_vWorldCoord.y) );
	int l_ditherPattern [4];
	l_ditherPattern[0] = 1;
	l_ditherPattern[1] = 0;
	l_ditherPattern[2] = 0;
	l_ditherPattern[3] = 1;
	
	int index = int(mod(float(pixelIndex.x), 2.0)) + int(mod(float(pixelIndex.y), 2.0)) * 2;
	int l_ditherSample = l_ditherPattern[index];
	
	//if (l_ditherSample == 0)
	//	discard;
		
	float pixelAlphaFutz = 0.0;
	// Perform some random sine-perturbation
	pixelAlphaFutz += sin(v_vWorldCoord.x * 0.17 + v_vWorldCoord.y * 0.08) * 0.1;
	pixelAlphaFutz += cos(v_vWorldCoord.x * 0.024 + v_vWorldCoord.y * 0.032) * 0.1 + 0.1;
	
	// Limit the futz to visible portions
	pixelAlphaFutz *= clamp(v_vColour.a * 8.0, 0.0, 1.0);
	
    gl_FragColor = clamp(v_vColour + vec4(0, 0, 0, pixelAlphaFutz), 0.0, 1.0);
}
