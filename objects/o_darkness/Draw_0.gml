/// @description draw the DARKNESS

// multiply mode:
if (surface_exists(m_darkness))
{
	var dx = GameCamera.x - GameCamera.width / 2;
	var dy = GameCamera.y - GameCamera.height / 2;
	
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	shader_set(sh_shadowBanding);
	draw_surface(m_darkness, dx, dy);
	shader_reset();
	gpu_set_blendmode(bm_normal);
}