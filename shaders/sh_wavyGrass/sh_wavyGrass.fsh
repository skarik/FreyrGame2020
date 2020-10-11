//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vWorldCoord;

void main()
{
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
	/*vec2 coord_offset = vec2(0, 0);
	
	float grass_angle = 0.0;
	//coord_offset.x += sin(i * 32.13124 + current_time * 0.002) * 2.0;
	grass_angle += sin(v_vWorldCoord.x * 0.042 + v_vWorldCoord.y * 0.016 + u_animationValues.x * 0.0017) * 10.0;
	
	vec3 grass_color = mix(vec3(1.0, 1.0, 1.0), vec3(0.2, 0.0, 0.0), abs(grass_angle - 3.0) / 60.0);
	
	coord_offset.x = grass_angle / 90.0 * 0.002 * v_vColour.a;*/
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	if (gl_FragColor.a < 0.5)
		discard;
	//gl_FragColor.rgb *= grass_color;
}
