/// @description Draw the thank you message

if (m_fade > 0.0)
{
	// Draw the overlay
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_one);
	draw_set_alpha(m_fade * 0.5);
	draw_set_color(c_black);
	draw_rectangle(0, 0, Screen.width, Screen.height, false);
	
	// Draw the message
	draw_set_alpha(m_fade);
	
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	
	draw_set_font(global.font_will14);
	draw_text_spaced(GameCamera.width / 2.0, GameCamera.height / 2.0 - 70, "THANK YOU", 3);
	draw_set_font(global.font_arvo10Bold);
	draw_text_spaced(GameCamera.width / 2.0, GameCamera.height / 2.0 - 40, "For trying our vertical slice!", 3);
	
	
	draw_set_alpha(m_fadeTotalMessage);
	draw_set_font(global.font_arvo9);
	draw_text_spaced(GameCamera.width / 2.0, GameCamera.height / 2.0 + 20, "The world is left open...", 3);
	draw_text_spaced(GameCamera.width / 2.0, GameCamera.height / 2.0 + 40, "Or press TAB and return to the menu.", 3);
	
	
	// Clean up
	draw_set_alpha(1.0);
	gpu_set_blendmode(bm_normal);
}