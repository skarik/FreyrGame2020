//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_spriteSize;
uniform vec4 u_spriteUVs;

void main()
{
	vec2 pixel_scale = u_spriteSize / (u_spriteUVs.zw - u_spriteUVs.xy);
	vec2 pixel = v_vTexcoord * pixel_scale;
	
	// emulate point sampling
	vec2 uv = floor(pixel) + 0.5;
    
	// subpixel aa algorithm (COMMENT OUT TO COMPARE WITH POINT SAMPLING)
	uv += 1.0 - clamp((1.0 - fract(pixel)) * 2.0, 0.0, 1.0);

	// output
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, uv / pixel_scale);
}
