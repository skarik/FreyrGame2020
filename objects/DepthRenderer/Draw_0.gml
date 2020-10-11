/// @description Render depth objects

var renderQueueSize = ds_list_size(m_renderQueue);

gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);

// Draw all the main passes in one go
for (var i = 0; i < renderQueueSize; ++i)
{
	var object = m_renderQueue[|i];
	var func = object.m_depthState.worldDraw;
	with (object) func();
}

var shadow_surface = surface_create(GameCamera.width, GameCamera.height);
surface_set_target(shadow_surface);
{
	// Save old matrix stack
	var mat_world_previous = matrix_get(matrix_world);
	var mat_view_previous = matrix_get(matrix_view);
	var mat_projection_previous = matrix_get(matrix_projection);
	
	// Offset the camera
	var mat_offset = matrix_build(-GameCamera.view_x, -GameCamera.view_y, 0, 0,0,0, 1,1,1);
	var mat_offset_world = matrix_multiply(mat_world_previous, mat_offset);
	matrix_set(matrix_world, mat_offset_world);
	
	draw_clear_alpha(c_white, 0.0);
	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	shader_set(sh_colormaskAlphatest);

	// Draw all the shadows to a side buffer
	for (var i = 0; i < renderQueueSize; ++i)
	{
		var object = m_renderQueue[|i];
		var func = object.m_depthState.shadowDraw; // TODO: All shadows need to be drawn as sprites
		with (object) func();
	}

	shader_reset();
	
	// Reset to old matrix stack
	matrix_set(matrix_world, mat_world_previous);
	matrix_set(matrix_view, mat_view_previous);
	matrix_set(matrix_projection, mat_projection_previous);
}
surface_reset_target();

// Draw shadows on top of the depth layer???
gpu_set_blendmode_ext_sepalpha(bm_dest_color, bm_zero, bm_zero, bm_one);
draw_surface(shadow_surface, GameCamera.view_x, GameCamera.view_y);

// Done with surface
surface_free(shadow_surface);

// Done
gpu_set_blendmode(bm_normal);
gpu_set_alphatestenable(true);
