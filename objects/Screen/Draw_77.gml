/// @description Effects, upscale, push

view_set_camera(1, m_outputCamera);
view_set_visible(0, false);
view_set_visible(1, true);

// Game output is currently drawn to m_gameSurface
// We want to also fill in m_uiSurface
surface_set_target(m_uiSurface);
{
	draw_clear_alpha(c_black, 0.0);
	
	// render UI objects
	{
		// Create the priority queue of all UI objects
		var ui_queue = ds_priority_create();
		with (ob_userInterfaceElement)
		{
			ds_priority_add(ui_queue, id, depth);
		}
		
		// Draw all the UI objects in order
		while (!ds_priority_empty(ui_queue))
		{
			with (ds_priority_delete_min(ui_queue))
			{
				event_user(kEvent_UIElementOnDraw0);
			}
		}
		
		// Draw remaining elements manually
		//with (o_PlayerHud) event_user(0);
		//with (o_CtsPortraitRenderer) event_user(0);
		//with (o_CtsTalkerBox) event_user(0);
		
		ds_priority_destroy(ui_queue);
	}
	
	// And we're done here
}	
surface_reset_target();

// update effects (UI)
{
	// Create priority queue of all effect objects
	var effect_queue = ds_priority_create();
	with (ob_screenEffect)
	{
		if (m_applyToUI)
		{
			ds_priority_add(effect_queue, id, m_depth);
		}
	}
	
	// Execute all effects in order
	while (!ds_priority_empty(effect_queue))
	{
		with (ds_priority_delete_min(effect_queue))
		{
			event_user(kEvent_ScreenEffectOnUI1);
		}
	}
	
	ds_priority_destroy(effect_queue);
}

// update effects (Game)
{
	// Create priority queue of all effect objects
	var effect_queue = ds_priority_create();
	with (ob_screenEffect)
	{
		if (m_applyToGame)
		{
			ds_priority_add(effect_queue, id, m_depth);
		}
	}
	
	// Execute all effects in order
	while (!ds_priority_empty(effect_queue))
	{
		with (ds_priority_delete_min(effect_queue))
		{
			event_user(kEvent_ScreenEffectOnGame0);
		}
	}
	
	ds_priority_destroy(effect_queue);
}

// composite both game & UI in post
var l_bufferGameAndUiComposite = surface_create_from_surface_params(m_gameSurface);
surface_set_target(l_bufferGameAndUiComposite);
{
	gpu_set_blendenable(false);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	draw_surface(m_gameSurface, 0, 0);
	
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_surface(m_uiSurface, 0, 0);
}
surface_reset_target();

// Upscale to the screen
surface_set_target(m_outputSurface);
camera_apply(m_outputCamera);
{
	gpu_set_blendenable(false);
	gpu_set_blendmode_ext(bm_one, bm_zero);
	
	// Clear the screen
	draw_clear(c_black);
	
	// Debug blue to show which area is actually renderable
	if (Debug.visible)
	{
		draw_set_color(c_blue);
		draw_rectangle(0, 0, Screen.width * 0.9, Screen.height * 0.9, false); // Debug blue.
	}
	
	// Draw the screen
	draw_set_color(c_white);
	draw_surface_stretched(l_bufferGameAndUiComposite, offset_x * pixelScale, offset_y * pixelScale, Screen.width, Screen.height);
}
surface_reset_target();

// Copy to the backbuffer
camera_apply(m_outputCamera);
gpu_set_blendenable(false);
gpu_set_blendmode_ext(bm_one, bm_zero);
draw_set_color(c_white);
if (!window_get_fullscreen())
{
	draw_surface_stretched(m_outputSurface, 0, 0, window_get_width(), window_get_height());
}
else
{
	var scale_x = Screen.width / display_get_width();
	var scale_y = Screen.height / display_get_height();
	draw_surface_stretched(m_outputSurface, 0, 0, display_get_width() * scale_x, display_get_height() * scale_y);
}

// Draw debug info in the top left corner
if (kScreenCorner_DrawDevelopmentInfo)
{
	draw_set_alpha(0.25);
	draw_set_color(c_white);
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_set_font(f_openSans7);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text(2, 2, kScreenCorner_String);
	draw_set_alpha(1.0);
}

// Release the temp buffers
surface_free(l_bufferGameAndUiComposite);

// Release the used buffers
//surface_free_if_exists(m_outputSurface);
surface_free_if_exists(m_uiSurface);
// Store history of game surface sans-UI
surface_free_if_exists(m_gameSurfaceHistory[0]);
m_gameSurfaceHistory[0] = m_gameSurface;
m_gameSurface = null;

// Store history of our final output
surface_free_if_exists(m_outputSurfaceHistory[0]);
m_outputSurfaceHistory[0] = m_outputSurface;
m_outputSurface = null;