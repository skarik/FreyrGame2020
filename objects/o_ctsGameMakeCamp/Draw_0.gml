/// @description Draw world flash

if (m_vfxWorldFlash > 0.0)
{
	gpu_set_blendmode_ext(bm_dest_color, bm_one);
	draw_set_color(merge_color(c_black, c_white, m_vfxWorldFlash));
	draw_rectangle(GameCamera.view_x - 1,
					GameCamera.view_y - 1,
					GameCamera.view_x + GameCamera.width + 1,
					GameCamera.view_x + GameCamera.height + 1,
					false);
	gpu_set_blendmode(bm_normal);
}
