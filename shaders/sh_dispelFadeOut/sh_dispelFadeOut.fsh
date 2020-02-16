//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vWorldCoord;

uniform sampler2D samplerTexNoise;

uniform vec2 uTexNoiseSize;
uniform vec4 uTexNoiseCoords;
uniform float uEffectiveAlpha;

void main()
{
	vec2 noise_offset = uTexNoiseCoords.xy;
	vec2 noise_size = uTexNoiseCoords.zw - uTexNoiseCoords.xy;
	vec2 noise_coords = v_vWorldCoord / uTexNoiseSize; // Base coords
	noise_coords = noise_offset + mod(noise_coords, 1.0) * noise_size; // Resize for the atlas
	vec4 noise_tex = texture2D( samplerTexNoise, noise_coords );
	
	// as the alpha approaches 0, fade it all the way out
	if ((noise_tex.b * 0.99 + 0.005) > uEffectiveAlpha)
		discard;
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	//gl_FragColor.rgb = noise_tex.rrr;
	//gl_FragColor  = v_vColour;
}
