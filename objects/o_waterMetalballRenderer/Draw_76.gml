/// @description Update surface

if (exists(o_waterMetaball))
{
	if (!surface_exists(m_surface))
	{
		m_surface = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
	}
	
	if (surface_exists(m_surface))
	{
		surface_set_target(m_surface);
		
		gpu_set_blendenable(false);
		draw_clear_alpha(c_black, 0.0);
		
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_add);
		with (o_waterMetaball)
		{
			draw_circle_color(x - GameCamera.view_x, y - GameCamera.view_y, 64 * image_xscale, c_gray, c_black, false);
		}
		
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
	}
}