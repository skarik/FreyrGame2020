/// @description Update surface

if (exists(ob_areaFarmable))
{
	if (!surface_exists(m_surface))
	{
		m_surface = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
	}
	
	// Update the effect surface that dictates what is where...
	if (surface_exists(m_surface))
	{
		surface_set_target(m_surface);
		
		gpu_set_blendenable(false);
		draw_clear_alpha(c_black, 0.0);
		
		gpu_set_blendenable(true);
		gpu_set_blendmode(bm_add);
		
		draw_set_color(c_white);
		with (o_waterMetaball64)
		{
			draw_circle_color(
				x - GameCamera.view_x, y - GameCamera.view_y,
				64 * image_xscale * 1.5,
				make_color_rgb(128, 250, 0), c_black, false);
		}
		
		draw_set_color(make_color_rgb(0,0,255));
		with (ob_areaFarmable)
		{
			draw_rectangle(
				x - GameCamera.view_x, y - GameCamera.view_y,
				x + sprite_width - GameCamera.view_x, y + sprite_height - GameCamera.view_y,
				false);
		}
		with (o_farmlandMetaball64)
		{
			draw_circle_color(
				x - GameCamera.view_x, y - GameCamera.view_y,
				64 * image_xscale,
				c_maroon, c_black, false);
		}
		with (o_fieldSquare)
		{
			draw_circle_color(
				x - GameCamera.view_x + 8, y - GameCamera.view_y + 8,
				12 + abs(sin(id * 623.12121) * 2),
				watered ? make_color_rgb(128, 255, 0) : c_maroon, c_black, false);
		}
		
		gpu_set_blendmode(bm_normal);
		surface_reset_target();
	}
	
	if (!surface_exists(m_surfacePeturb))
	{
		m_surfacePeturb = surface_create(16, 16);
	}
	// Update the peturb surface (todo: optimize this)
	if (surface_exists(m_surfacePeturb))
	{
		surface_set_target(m_surfacePeturb);
		gpu_set_blendenable(false);
		draw_sprite(s_bumpDirtPeturb, 0, 0, 0);
		surface_reset_target();
	}
}