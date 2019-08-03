/// @description Update surfaces

if (!exists(o_waterMetaball))
{
	exit;
}

//
// Update metalball surface
//
if (!surface_exists(m_surface))
{
	m_surface = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
}
// Update the metaball surface (where what is where)
if (surface_exists(m_surface))
{
	surface_set_target(m_surface);
		
	gpu_set_blendenable(false);
	draw_clear_alpha(c_black, 0.0);
		
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_add);
	with (o_waterMetaball)
	{
		event_user(0);
	}
	with (o_shoreMetaball)
	{
		event_user(0);
	}
		
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}
	
if (!surface_exists(m_surfacePeturb))
{
	m_surfacePeturb = surface_create(32, 32);
}
// Update the peturb surface (todo: optimize this)
if (surface_exists(m_surfacePeturb))
{
	surface_set_target(m_surfacePeturb);
		
	gpu_set_blendenable(false);
	draw_sprite(s_bumpDirtPeturb, 0, 0, 0);
	draw_sprite(s_bumpDirtPeturb, 0, 16, 0);
	draw_sprite(s_bumpDirtPeturb, 0, 0, 16);
	draw_sprite(s_bumpDirtPeturb, 0, 16, 16);
		
	gpu_set_blendenable(true);
	gpu_set_blendmode(bm_normal);
	draw_sprite_ext(s_bumpDirtPeturb, 0, 0, 0, 2, 2, 0, c_white, 0.25);
		
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_color(make_color_rgb(255, 255, 0));
	draw_rectangle(0, 0, 64, 64, false);
		
	gpu_set_blendmode(bm_add);
	draw_sprite(s_waterOverlayCaustic, 0, 0, 0);
		
	gpu_set_blendmode(bm_normal);
	surface_reset_target();
}

//
// Render reflections
//
if (!surface_exists(m_surfaceReflect))
{
	m_surfaceReflect = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
}
if (!surface_exists(m_surfaceReflect_Temp))
{
	m_surfaceReflect_Temp = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
}
if (!surface_exists(m_surfaceDepthHack))
{
	m_surfaceDepthHack = surface_create(Screen.width / Screen.pixelScale, Screen.height / Screen.pixelScale);
}
if (surface_exists(m_surfaceReflect))
{
	var screen_bias = Screen.height / Screen.pixelScale;
	
	// Create depth-sorted render list
	var render_queue = ds_priority_create();
	var render_list = array_create(0);
	var rendered_map = ds_map_create();
	
	// Sort the water areas by depth
	var water_queue = ds_priority_create();
	var water_area;
	var water_area_count = instance_number(o_waterMetaball);
	for (var i = 0; i < water_area_count; ++i)
	{
		water_area = instance_find(o_waterMetaball, i);
		ds_priority_add(water_queue, water_area, water_area.z);
	}
	
	// Run through the water areas
	for (var i = 0; i < water_area_count; ++i)
	{
		water_area = ds_priority_delete_min(water_queue);
	
		var left = instance_get_left(water_area);
		var right = instance_get_right(water_area);
		var top = instance_get_top(water_area);
		var bottom = instance_get_bottom(water_area);
	
		if (right > GameCamera.view_x - 64
			|| left < GameCamera.view_x + GameCamera.width + 64
			|| bottom > GameCamera.view_y - 64
			|| top < GameCamera.view_y + GameCamera.height + 64)
		{
			// Render reflections for this object
			with (ob_character)
			{
				if (x < left - 64 || x > right + 64
					|| y < top - 128 || y > bottom + 16) continue;
				
				if (z + 16 < water_area.z) continue;
				if (ds_map_exists(rendered_map, id)) continue;
				
				var draw_x = x - GameCamera.view_x;
				var draw_y = y - GameCamera.view_y;
				draw_y = screen_bias - (draw_y - 2.0 * (water_area.z - (z + z_height)));
				
				var index = array_length_1d(render_list);
				ds_priority_add(render_queue, index, depth);
				render_list[index] = [id, draw_x, draw_y];
				rendered_map[? id] = water_area.z; // Mark as seen
			}
			
			// Add props
			with (ob_doodad)
			{
				if (x < left - 64 || x > right + 64
					|| y < top - 128 || y > bottom + 16) continue;
				
				if (z + 16 < water_area.z) continue;
				if (ds_map_exists(rendered_map, id)) 
				{
					if (sprite_height < 100)
						continue;
					else if (rendered_map[? id] == water_area.z)
						continue;
				}
				
				var draw_x = x - GameCamera.view_x;
				var draw_y = y - GameCamera.view_y;
				draw_y = screen_bias - (draw_y - 2.0 * (water_area.z - (z + z_height)));
				
				var index = array_length_1d(render_list);
				ds_priority_add(render_queue, index, depth);
				render_list[index] = [id, draw_x, draw_y];
				rendered_map[? id] = water_area.z; // Mark as seen
			}
		}
	}
	ds_priority_destroy(water_queue);

	// Create temp reusable queue
	var l_renderQueue = ds_priority_create();

	// Render the reflection color
	ds_priority_copy(l_renderQueue, render_queue);
	surface_set_target(m_surfaceReflect_Temp);
	{
		draw_clear_alpha(c_black, 0.0);
	
		// Loop thru priority queue and render the objects
		var render_count = ds_priority_size(l_renderQueue);
		for (var i = 0; i < render_count; ++i)
		{
			var info_to_render = render_list[ds_priority_delete_max(l_renderQueue)];
			with (info_to_render[0])
			{
				var pos = drawbuf_save_position_depth();
				drawbuf_set_reflection(true);
		
				x = info_to_render[1];
				y = info_to_render[2];
				z = 0;
				z_height = 0;
		
				event_perform(ev_draw, 0);
		
				drawbuf_set_reflection(false);
				drawbuf_restore_position_depth(pos);
			}
		}
	}
	surface_reset_target();
	ds_priority_clear(l_renderQueue);
	
	// Render the fake-depth tool
	ds_priority_copy(l_renderQueue, render_queue);
	surface_set_target(m_surfaceDepthHack);
	{
		draw_clear_alpha(c_black, 0.0);
		
		gpu_set_blendmode(bm_add);
	
		// Loop thru priority queue and render the objects
		var render_count = ds_priority_size(l_renderQueue);
		for (var i = 0; i < render_count; ++i)
		{
			var info_to_render = render_list[ds_priority_delete_max(l_renderQueue)];
			with (info_to_render[0])
			{
				/*var left = info_to_render[1] - sprite_xoffset;
				var right = info_to_render[1] - sprite_xoffset + sprite_width;
				var c_blend = merge_color(c_red, c_black, saturate(abs(sprite_height) / 128));
				draw_rectangle_color(left, info_to_render[2],
									 right, info_to_render[2] - min(128, abs(sprite_height)),
									 c_blend, c_blend,
									 c_red, c_red,
									 false);*/
				draw_circle_color(info_to_render[1], info_to_render[2],
								  abs(sprite_height),
								  c_red, c_black, false);
			}
		}
		
		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target();
	ds_priority_clear(l_renderQueue);
	
	// Mask out the reflection & distort it
	surface_set_target(m_surfaceReflect)
	draw_clear_alpha(c_black, 0.0);
	
	shader_set(sh_waterReflectRender);
	texture_set_stage(uni_samplerWaterMask, surface_get_texture(m_surface));
	texture_set_stage(uni_samplerDepthHack, surface_get_texture(m_surfaceDepthHack));
	shader_set_uniform_f(uni_currentTimeReflection, current_time / 1000.0);
	shader_set_uniform_f(uni_viewOffset, -GameCamera.view_x, -GameCamera.view_y, 0, 0);
	draw_surface(m_surfaceReflect_Temp, 0, 0);
	shader_reset();
	
	surface_reset_target();
	
	// Free render list
	ds_map_destroy(rendered_map);
	ds_priority_destroy(l_renderQueue);
	ds_priority_destroy(render_queue);
}