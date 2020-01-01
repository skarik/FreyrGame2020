/// @description Render all the shadows

//o_ashadowCloudMover_Renderer

var l_cloudShadowSurface = surface_create(GameCamera.width, GameCamera.height);

surface_set_target(l_cloudShadowSurface);

	// Clear the buffer
	draw_clear_alpha(c_white, 1.0);

	// Draw all cloud shadows
	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	
	with (o_ashadowCloudMover)
	{
		xoffset = -GameCamera.view_x;
		yoffset = -GameCamera.view_y;
	
		event_user(0);
	}
	
	// Reduce the shadow strength
	draw_set_alpha(0.9);
	draw_set_color(c_white);
	draw_rectangle(0, 0, GameCamera.width, GameCamera.height, false);
	draw_set_alpha(1.0);
	
surface_reset_target();

// go to multiply
gpu_set_blendmode_ext(bm_dest_color, bm_zero);
// draw the lighting
draw_surface(l_cloudShadowSurface, 0, 0);
// go back to normal
gpu_set_blendmode(bm_normal);

// no longer need shadow surface
surface_free(l_cloudShadowSurface);