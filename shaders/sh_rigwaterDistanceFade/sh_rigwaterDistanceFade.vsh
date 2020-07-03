//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                    // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec4 v_vPosition;
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vFutzValues;
varying vec3 v_vNormal;
varying vec4 v_vWorldPosition;

vec2 round (vec2 value)
{
	vec2 result = value;// + vec2(0.5, 0.5);
	result -= fract(result);
	return result;
}

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    v_vPosition = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
	vec2 round_level = vec2(320, 180);
	v_vPosition.xyz = v_vPosition.xyz / v_vPosition.w;
	v_vPosition.xy = round(v_vPosition.xy * round_level) / round_level; 
	v_vPosition.xyz = v_vPosition.xyz * v_vPosition.w;
	
	gl_Position = v_vPosition;
	
	float futzDistance = length(gm_Matrices[MATRIX_WORLD_VIEW] * object_space_pos);
	v_vFutzValues.x = futzDistance + (v_vPosition.w * 8.0) / futzDistance / 2.0;
	v_vFutzValues.y = v_vFutzValues.x;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
	v_vTexcoord *= v_vFutzValues.x; // Create a fake distorted tex coord
	v_vWorldPosition = gm_Matrices[MATRIX_WORLD] * object_space_pos;
	v_vWorldPosition.w = futzDistance;
	
	v_vNormal = mat3(gm_Matrices[MATRIX_WORLD]) * in_Normal;
}
