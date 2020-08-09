//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 u_spriteSize;
uniform vec4 u_spriteUVs;

void main()
{
	vec4 finalColor = vec4(0, 0, 0, 0);
	// o = offset, the width of a pixel
	vec2 o = (u_spriteUVs.zw - u_spriteUVs.xy) / u_spriteSize;
	// texel arrangement
	// A B C
	// D E F
	// G H I
	vec4 A = texture2D(gm_BaseTexture, v_vTexcoord + vec2( -o.x,  o.y));
	vec4 B = texture2D(gm_BaseTexture, v_vTexcoord + vec2(    0,  o.y));
	vec4 C = texture2D(gm_BaseTexture, v_vTexcoord + vec2(  o.x,  o.y));
	vec4 D = texture2D(gm_BaseTexture, v_vTexcoord + vec2( -o.x,    0));
	vec4 E = texture2D(gm_BaseTexture, v_vTexcoord + vec2(    0,    0));
	vec4 F = texture2D(gm_BaseTexture, v_vTexcoord + vec2(  o.x,    0));
	vec4 G = texture2D(gm_BaseTexture, v_vTexcoord + vec2( -o.x, -o.y));
	vec4 H = texture2D(gm_BaseTexture, v_vTexcoord + vec2(    0, -o.y));
	vec4 I = texture2D(gm_BaseTexture, v_vTexcoord + vec2(  o.x, -o.y));
	vec2 p = v_vTexcoord / (u_spriteUVs.zw - u_spriteUVs.xy) * u_spriteSize;
	// p = the position within a pixel [0...1]
	p = p - floor(p);
	if (p.x > .5)
	{
		if (p.y > .5)
		{
			// Top Right
			finalColor = B == F && B != D && F != H ? F : E;
		}
		else
		{
			// Bottom Right
			finalColor = H == F && D != H && B != F ? F : E;
		}
	}
	else
	{
		if (p.y > .5) 
		{
			// Top Left
			finalColor = D == B && B != F && D != H ? D : E;
		}
		else
		{
			// Bottom Left
			finalColor = D == H && D != B && H != F ? D : E;
		}
	}
	
    gl_FragColor = v_vColour * finalColor;//texture2D( gm_BaseTexture, v_vTexcoord );
}
