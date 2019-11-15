//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vWorldCoord;

uniform vec4 u_animationValues;

#define kDEG_TO_RAD 0.01745329

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);

	/*
	var i_grass = m_grassBits[i];
	var pl_dist = sqr(i_grass[0] - pl.x) + sqr(i_grass[1] - pl.y) * 3.0;
	
	var grass_angle = 0.0;
	grass_angle += -25.0 * max(0.0, (40.0 - pl_dist * 0.07) / 40.0) * sign(i_grass[0] - pl.x);
	
	grass_angle += sin(i * 32.13124 + current_time * 0.002) * 2.0;
	grass_angle += sin(i_grass[0] * 0.042 + i_grass[1] * 0.016 + current_time * 0.0017) * 10.0;
	
	var grass_color = merge_color(c_white, c_black, abs(grass_angle - 3.0) / 60.0);
	
	draw_sprite_ext(s_assetTallGrass, i_grass[2], i_grass[0], i_grass[1], i_grass[3], 1.0, grass_angle, grass_color, 1.0);
	*/
	
	float grass_angle = 0.0;
	grass_angle += sin(in_Colour.z * 32.13124 + u_animationValues.x * 0.002 * 1000.0) * 2.0;
	grass_angle += sin(in_Colour.x * 0.042 + in_Colour.y * 0.016 + u_animationValues.x * 1.7) * 10.0;
	grass_angle -= atan(u_animationValues.z * 0.05 * (sin(in_Colour.x * 0.053 + in_Colour.y * 0.017 + u_animationValues.x * 1.9) * 0.5 + 1.0) ) * 14.0;
	
	vec3 grass_color = mix(vec3(1.0, 1.0, 1.0), vec3(0.2, 0.0, 0.0), abs(grass_angle - 3.0) / 60.0);
	
	//vec2 coord_offset = vec2(0, 0);
	//coord_offset.x = grass_angle / 90.0 * 0.002 * v_vColour.a;
	
	object_space_pos.x += in_Colour.a * sin(-grass_angle * kDEG_TO_RAD);
	object_space_pos.y += in_Colour.a * (1.0 - cos(-grass_angle * kDEG_TO_RAD));
	
	// Emit output:
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = vec4(grass_color.rgb, 1.0);
    v_vTexcoord = in_TextureCoord;
	v_vWorldCoord = object_space_pos.xy;
}
