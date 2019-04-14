/// @description update the darkness

if (!surface_exists(m_darkness))
{
	m_darkness = surface_create(GameCamera.width, GameCamera.height);
}

if (surface_exists(m_darkness))
{
	var offset_x = -(GameCamera.x - GameCamera.width / 2);
	var offset_y = -(GameCamera.y - GameCamera.height / 2)
	
	surface_set_target(m_darkness);
	
	// clear to the ambient color
	draw_clear_alpha(o_dayNightCycle.m_ambientLight, 1.0);
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
		draw_circle_color(x + offset_x, y + offset_y - z_height, 100, c_dkgray, c_black, false);
	}
	with (o_PlayerTest) // Todo: add companions to this
	{
		// Draw a small light around big characters
		draw_circle_color(x + offset_x, y + offset_y - z_height, 200, c_gray, c_black, false);
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