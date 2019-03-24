/// @description Update surface

if (exists(o_waterMetaball))
{
	if (!surface_exists(m_surface))
	{
		m_surface = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
	}
	// Update the metaball surface (where what is where)
	if (surface_exists(m_surface))
	{
		surface_set_target(m_surface);
		
		gpu_set_blendenable(false);
		draw_clear_alpha(c_black, 0.0);
		
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_add);
		with (o_waterMetaball)
		{
			event_user(0);
		}
		
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
	}
	
	if (!surface_exists(m_surfacePeturb))
	{
		m_surfacePeturb = surface_create(32, 32);
	}
	// Update the peturb surface (todo: optimize this)
	if (surface_exists(m_surfacePeturb))
	{
		surface_set_target(m_surfacePeturb);
		
		gpu_set_blendenable(false);
		draw_sprite(s_bumpDirtPeturb, 0, 0, 0);
		draw_sprite(s_bumpDirtPeturb, 0, 16, 0);
		draw_sprite(s_bumpDirtPeturb, 0, 0, 16);
		draw_sprite(s_bumpDirtPeturb, 0, 16, 16);
		
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_normal);
		draw_sprite_ext(s_bumpDirtPeturb, 0, 0, 0, 2, 2, 0, c_white, 0.25);
		
		gpu_set_blendmode_ext(bm_dest_color, bm_zero);
		draw_set_color(make_color_rgb(255, 255, 0));
		draw_rectangle(0, 0, 64, 64, false);
		
		gpu_set_blendmode(bm_add);
		draw_sprite(s_waterOverlayCaustic, 0, 0, 0);
		
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
		
	}
}