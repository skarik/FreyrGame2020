/// @description Draw the VIGGO!

if (m_state == Cts.S1DeadOverlay)
{
	var l_textFade = clamp(m_timer * 6.0, 0.0, 1.0) * clamp((1.0 - m_timer) * 6.0, 0.0, 1.0);
	var l_scale = 0.8 + 0.2 * clamp(m_timer * 2.0, 0.0, 1.0);
	
	draw_set_color(c_white);
	shader_set(sh_colormask);
	draw_sprite_ext(sui_youDied, 1, GameCamera.x - 1, GameCamera.y, l_scale, l_scale, 0.0, c_black, l_textFade);
	draw_sprite_ext(sui_youDied, 1, GameCamera.x + 1, GameCamera.y, l_scale, l_scale, 0.0, c_black, l_textFade);
	draw_sprite_ext(sui_youDied, 1, GameCamera.x, GameCamera.y - 1, l_scale, l_scale, 0.0, c_black, l_textFade);
	draw_sprite_ext(sui_youDied, 1, GameCamera.x, GameCamera.y + 1, l_scale, l_scale, 0.0, c_black, l_textFade);
	shader_reset();
	draw_sprite_ext(sui_youDied, 1, GameCamera.x, GameCamera.y, l_scale, l_scale, 0.0, c_white, l_textFade);
	
	shader_set(sh_colormask);
	draw_sprite_ext(sui_youDied, 2, GameCamera.x, GameCamera.y, l_scale, l_scale, 0.0, c_red, l_textFade * 0.6);
	shader_reset();


}