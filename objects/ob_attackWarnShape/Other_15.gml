/// @description Unified draw

if (image_alpha > 0.0)
{
	if (mesh_ready)
	{
		// Draw the warning area
		shader_set(sh_magiSightPrims);
		vertex_submit(mesh, m_primitive, sprite_get_texture(s_effectWhite64, 0));
		shader_reset();

		// On top of it, draw the warning UI
		if (m_draw_text)
		{	
			draw_set_alpha(saturate(image_alpha));
			draw_set_color(c_uigold);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(global.font_arvo9);
			draw_text_spaced(text_x, text_y,
							 "-!-", 4);
			draw_set_alpha(1.0);
		}
	}
}