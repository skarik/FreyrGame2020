//
// Simple passthrough fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec4 uPaletteAtlasCoords;
uniform float uCurrentTime;

float shCenter ( float trigonometric )
{
	return trigonometric * 0.5 + 0.5;
}

void main()
{
	vec2 l_correctedCoords = (v_vTexcoord.xy - uPaletteAtlasCoords.xy) / uPaletteAtlasCoords.zw;
	vec2 l_centerCoordDelta = l_correctedCoords - vec2(0.5, 0.5);
	
	// Calculate the angle to the pixel from the center
	float l_angle = atan(l_centerCoordDelta.x, l_centerCoordDelta.y);
	// Calculate the distance from the center
	float l_distance = sqrt(dot(l_centerCoordDelta, l_centerCoordDelta));
	
	float l_finalRadius = l_distance;
	// peturb the edges a little
	l_finalRadius += shCenter(sin(l_angle * 10.0 + uCurrentTime * 1.7)) * 0.03;
	l_finalRadius += shCenter(cos(l_angle * 14.0 - uCurrentTime * 6.0)) * 0.03;
	l_finalRadius += shCenter(sin(l_angle * 6.0  + uCurrentTime * 0.7)) * 0.05;
	l_finalRadius += shCenter(cos(l_angle * 4.0  - uCurrentTime * 2.2)) * 0.01;
	// add some spikes
	float l_spikeAmount = max(0.0,
		max(0.0, cos(l_angle * 16.0 + uCurrentTime * 4.0))
		* sin(l_angle * 10.0 + uCurrentTime * 4.2 - 0.42)
		* cos(l_angle *  6.0 + uCurrentTime * 3.7 + 1.21)
		* sin(l_angle *  4.0 + uCurrentTime * 4.3 + 0.83)
		* sin(l_angle *  2.0 + uCurrentTime * 4.4 + 1.23)
		* sin(l_angle * 12.0 + uCurrentTime * 4.7 + 0.23)
		* cos(l_angle *  8.0 + uCurrentTime * 3.5 + 0.53)
		* cos(l_angle * 14.0 + uCurrentTime * 3.9 + 0.13)
		* sin(l_angle *  1.0 + uCurrentTime * 4.1 - 0.98)
		* sin(l_angle *  1.0 - uCurrentTime * 3.6 + 0.45)
		) * 0.5;
	l_finalRadius -= l_spikeAmount;
	// Push it a little smaller
	l_finalRadius += 0.1;
	
	// Make the angles that are halfcircle thinner
	const float kCenterAngle = 3.1415 / 2.0;
	float centerAnglePush = (kCenterAngle - abs(abs(l_angle) - kCenterAngle)) / kCenterAngle;
	l_finalRadius += 0.16 * pow(centerAnglePush, 0.5);
	
	// discard over the range
	if (l_finalRadius > 0.5)
		discard;
		
	// Use distance for coloring it.
	float normalizedRadius = l_finalRadius * 2.0;
	// Brighten the center
	normalizedRadius += 0.4 * max(0.0, 0.08 - l_distance) / 0.08;
	// Brighten spikes
	normalizedRadius += l_spikeAmount * 7.0;
	// Cel-shade it
	float edgeBrightness = (ceil(normalizedRadius * 15.0) - 13.0) / 2.0;
	edgeBrightness = clamp(edgeBrightness, 0.0, 1.0);
	
    //gl_FragColor = vec4(edgeBrightness * 0.2, edgeBrightness * 0.8, edgeBrightness * 0.4, 1.0);
	gl_FragColor = vec4(edgeBrightness * 0.4, edgeBrightness * 1.0, edgeBrightness * 0.2, 1.0);
}
