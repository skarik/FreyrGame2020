//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec4 v_vTexCoords[4];
varying vec4 v_vColour;

uniform vec2 u_spriteSize;
uniform vec4 u_spriteUVs;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
	
	vec2 ps = (u_spriteUVs.zw - u_spriteUVs.xy) / u_spriteSize;
	float dx = ps.x;
	float dy = ps.y;

	//   +----+----+----+
	//   |    |    |    |
	//   | w1 | w2 | w3 |
	//   +----+----+----+
	//   |    |    |    |
	//   | w4 | w5 | w6 |
	//   +----+----+----+
	//   |    |    |    |
	//   | w7 | w8 | w9 |
	//   +----+----+----+
	
	v_vTexCoords[0].zw = ps;
	v_vTexCoords[0].xy = in_TextureCoord.xy;
	v_vTexCoords[1] = in_TextureCoord.xxxy + vec4(-dx, 0, dx, -dy); //  w1 | w2 | w3
	v_vTexCoords[2] = in_TextureCoord.xxxy + vec4(-dx, 0, dx,   0); //  w4 | w5 | w6
	v_vTexCoords[3] = in_TextureCoord.xxxy + vec4(-dx, 0, dx,  dy); //  w7 | w8 | w9
}
