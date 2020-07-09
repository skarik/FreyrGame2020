/// @description Update water texture

buffer_waterTexture = surface_create(32, 32);
surface_set_target(buffer_waterTexture);
{
	//draw_clear(make_color_rgb(39, 100, 104));
	draw_clear(make_color_rgb(24, 63, 57));
		
	gpu_set_blendmode(bm_add);
	shader_set(sh_desaturateX3);
	
	var dc = make_color_rgb(116, 186, 234);
	draw_sprite_ext(s_waterOverlayCaustic, 0, 0,0, 1,1,0, dc, 1.0);
	draw_sprite_ext(s_waterOverlayCaustic, 0, 0,0, 1,1,0, dc, 1.0);
	draw_sprite_ext(s_waterOverlayCaustic, 0, 0,0, 1,1,0, dc, 1.0);
	
	var dx = 16 + sin(Time.time * 1.1) * 8;
	var dy = 16 + sin(Time.time * 1.2) * 8;
	draw_sprite_tiled(s_waterOverlayCaustic, 0, dx, dy);
	
	shader_reset();
	gpu_set_blendmode(bm_normal);
}
surface_reset_target();