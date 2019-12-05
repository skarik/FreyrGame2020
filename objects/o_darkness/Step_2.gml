/// @description update the darkness

if (!surface_exists(m_darkness))
{
	m_darkness = surface_create(GameCamera.width, GameCamera.height);
}
if (!surface_exists(m_bloom))
{
	m_bloom = surface_create(GameCamera.width / 2, GameCamera.height / 2);
}
if (!surface_exists(m_bloom2))
{
	m_bloom2 = surface_create(GameCamera.width / 2, GameCamera.height / 2);
}

// update bloom params
if (exists(o_dayNightCycle) || exists(ob_ambientLighting))
{
	var ambient_color = c_black;
	if (exists(ob_ambientLighting))
	{
		ambient_color = ob_ambientLighting.m_ambientColor;
	}
	else if (exists(o_dayNightCycle))
	{
		ambient_color = o_dayNightCycle.m_ambientLight;
	}
	
	bloom_mul = 1.8 * saturate(0.8 - color_get_value(ambient_color) / 150);
	bloom_drop = saturate(0.5 + color_get_value(ambient_color) / 255);
	
	if (exists(ob_ambientLighting))
	{
		bloom_mul += ob_ambientLighting.m_bloomMulOffset;
		bloom_drop += ob_ambientLighting.m_bloomDropOffset;
	}
}
else
{
	bloom_mul = 0.5;
	bloom_drop = 0.9;
}

// draw lights
if (surface_exists(m_darkness))
{
	var offset_x = -(GameCamera.x - GameCamera.width / 2);
	var offset_y = -(GameCamera.y - GameCamera.height / 2)
	
	surface_set_target(m_darkness);
	
	// clear to the ambient color
	if (exists(ob_ambientLighting))
	{
		draw_clear_alpha(ob_ambientLighting.m_ambientColor, 1.0);
	}
	else if (exists(o_dayNightCycle))
	{
		draw_clear_alpha(o_dayNightCycle.m_ambientLight, 1.0);
	}
	else
	{
		draw_clear_alpha(c_white, 1.0);
	}
	// double it up
	gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
	draw_set_color(c_white);
	draw_rectangle(0, 0, GameCamera.width, GameCamera.height, false);
	
	// set up super acurrate mode:
	draw_set_circle_precision(64);
	
	// draw light sources:
	
	// water light sources:
	// TODO:
	
	// character light sources:
	gpu_set_blendmode_ext(bm_src_alpha, bm_one);
	
	with (ob_character)
	{	
		// Skip certain teams
		if (m_team == kTeamNone || m_team == kTeamMonster)
			continue;
		
		// Draw a small light around certain characters
		draw_circle_color(x + offset_x, y + offset_y - z_height, 125, merge_color(c_dkgray, c_black, 0.5), c_black, false);
	}
	with (o_PlayerTest) // Todo: add companions to this
	{
		// Draw a small light around big characters
		draw_circle_color(x + offset_x, y + offset_y - z_height, 75, merge_color(c_dkgray, c_black, 0.5), c_black, false);
		draw_circle_color(x + offset_x, y + offset_y - z_height, 50, merge_color(c_dkgray, c_black, 0.5), c_black, false);
	}
	
	// normal light sources:
	gpu_set_blendmode_ext(bm_src_alpha, bm_one);
	
	with (ob_light)
	{
		this.xoffset = offset_x;
		this.yoffset = offset_y;
		event_user(0);
	}
	
	// reset blend modes and draw modes
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1.0);
	draw_set_circle_precision(24);

	surface_reset_target();
}