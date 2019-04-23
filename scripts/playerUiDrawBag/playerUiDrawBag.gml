if (m_bag_totalBlend <= 0.01) exit;

surface_reset_target();
surface_set_target(m_surface);

var dx, dy;
dx = (Screen.width / Screen.pixelScale) / 2;
dy = round(((Screen.height / Screen.pixelScale) - 160) * 1.0 - 16.0);
dy += (1.0 - bouncestep(smoothstep(m_bag_totalBlend))) * 100 + (1.0 - smoothstep(m_bag_totalBlend)) * 80;

var smooth_blend = smoothstep(m_sbag_blend);

if (!m_sbag_seeds)
{
	var bag0_scalex = sprite_get_width(sui_inventory_bag_0_closed) / sprite_get_width(sui_inventory_bag_0);
	var bag0_scaley = sprite_get_height(sui_inventory_bag_0_closed) / sprite_get_height(sui_inventory_bag_0);
	
	var bag1_scalex = sprite_get_width(sui_inventory_bag_1) / sprite_get_width(sui_inventory_bag_1_closed);
	var bag1_scaley = sprite_get_height(sui_inventory_bag_1) / sprite_get_height(sui_inventory_bag_1_closed);
	
	// draw the unopened bag
	draw_sprite_ext(sui_inventory_bag_1_closed, 0,
					dx + lerp(110, 0, smooth_blend),
					dy + lerp(10, 0, smooth_blend),
					lerp(1.0, bag1_scalex, smooth_blend),
					lerp(1.0, bag1_scaley, smooth_blend),
					0.0,
					merge_color(c_ltgray, c_white, m_sbag_blend),
					1.0);
	// draw current bag
	draw_sprite_ext(sui_inventory_bag_0, 0,
					dx - lerp(0, 110, smooth_blend),
					dy + lerp(0, 10, smooth_blend),
					lerp(1.0, bag0_scalex, smooth_blend),
					lerp(1.0, bag0_scaley, smooth_blend),
					0.0,
					merge_color(c_white, c_ltgray, m_sbag_blend),
					1.0);
}
else
{
	var bag1_scalex = sprite_get_width(sui_inventory_bag_1_closed) / sprite_get_width(sui_inventory_bag_1);
	var bag1_scaley = sprite_get_height(sui_inventory_bag_1_closed) / sprite_get_height(sui_inventory_bag_1);
	
	var bag0_scalex = sprite_get_width(sui_inventory_bag_0) / sprite_get_width(sui_inventory_bag_0_closed);
	var bag0_scaley = sprite_get_height(sui_inventory_bag_0) / sprite_get_height(sui_inventory_bag_0_closed);
	
	// draw the unopened bag
	draw_sprite_ext(sui_inventory_bag_0_closed, 0,
					dx - lerp(0, 110, smooth_blend),
					dy + lerp(0, 10, smooth_blend),
					lerp(bag0_scalex, 1.0, smooth_blend),
					lerp(bag0_scaley, 1.0, smooth_blend),
					0.0,
					merge_color(c_white, c_ltgray, m_sbag_blend),
					1.0);
	// draw current bag
	draw_sprite_ext(sui_inventory_bag_1, 0,
					dx + lerp(110, 0, smooth_blend),
					dy + lerp(10, 0, smooth_blend),
					lerp(bag1_scalex, 1.0, smooth_blend),
					lerp(bag1_scaley, 1.0, smooth_blend),
					0.0,
					merge_color(c_ltgray, c_white, m_sbag_blend),
					1.0);
}

// draw everything in bag
var inventory = o_PlayerTest.inventory;

draw_set_color(c_white);
draw_set_font(f_04b03);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

if (abs(m_sbag_blend - 0.5) > 0.45)
{
	if (m_sbag_seeds == false)
	{
		var bag = inventory.bag;
		var bag_size = array_length_1d(bag);
	
		// store the bag offset
		m_bag_base_x = dx - sprite_get_xoffset(sui_inventory_bag_0);
		m_bag_base_y = dy;

		for (var i = 0; i < bag_size; ++i)
		{
			var item = bag[i];
			var offset = m_bag_offsets[i];
			var dix = offset[0] - sprite_get_xoffset(sui_inventory_bag_0) - 5;
			var diy = offset[1] - 5;
	
			//draw_sprite(sui_bagBox, 0, dx + dix, dy + diy );
	
			if (item.object != null)
			{
				draw_sprite(object_get_sprite(item.object), 0, dx + dix + 15, dy + diy + 15);
				draw_text(dx + dix + 25, dy + diy + 25, string(item.count));
			}
	
			// draw the hover selection
			if (i == m_bag_hover)
			{
				gpu_set_blendmode(bm_add);
				draw_set_color(merge_color(c_dkgray, c_gold, sin(current_time * 0.01) * 0.5 + 0.5));
				draw_rectangle(
					dx + dix + 15 - 11, dy + diy + 15 - 11,
					dx + dix + 15 + 9,  dy + diy + 15 + 9,
					true);
				draw_set_color(c_white);
				gpu_set_blendmode(bm_normal);
			}
			// draw the REAAAAL selection
			if (i == m_bag_selection)
			{
				gpu_set_blendmode(bm_add);
				draw_set_color(c_gold);
				draw_rectangle(
					dx + dix + 15 - 10, dy + diy + 15 - 10,
					dx + dix + 15 + 8,  dy + diy + 15 + 8,
					true);
				draw_set_color(c_white);
				gpu_set_blendmode(bm_normal);
			}
		}
	}
	else
	{
		var seed = inventory.seed;
		var seed_size = array_length_1d(seed);
	
		// store the bag offset
		m_seed_base_x = dx - sprite_get_xoffset(sui_inventory_bag_1);
		m_seed_base_y = dy;

		for (var i = 0; i < seed_size; ++i)
		{
			var item = seed[i];
			var offset = m_seed_offsets[i];
			var dix = offset[0] - sprite_get_xoffset(sui_inventory_bag_1) - 5;
			var diy = offset[1] - 5;
	
			//draw_sprite(sui_bagBox, 0, dx + dix, dy + diy );
	
			if (item.object != null)
			{
				draw_sprite(object_get_sprite(item.object), 0, dx + dix + 15, dy + diy + 15);
				draw_text(dx + dix + 25, dy + diy + 25, string(item.count));
			}
	
			// draw the hover selection
			if (i == m_seed_hover)
			{
				gpu_set_blendmode(bm_add);
				draw_set_color(merge_color(c_dkgray, c_gold, sin(current_time * 0.01) * 0.5 + 0.5));
				draw_rectangle(
					dx + dix + 15 - 11, dy + diy + 15 - 11,
					dx + dix + 15 + 9,  dy + diy + 15 + 9,
					true);
				draw_set_color(c_white);
				gpu_set_blendmode(bm_normal);
			}
			// draw the REAAAAL selection
			if (i == m_seed_selection)
			{
				gpu_set_blendmode(bm_add);
				draw_set_color(c_gold);
				draw_rectangle(
					dx + dix + 15 - 10, dy + diy + 15 - 10,
					dx + dix + 15 + 8,  dy + diy + 15 + 8,
					true);
				draw_set_color(c_white);
				gpu_set_blendmode(bm_normal);
			}
		}
	}
}

/*
draw_sprite(sui_bookElements, 0, dx + 40, dy + 4);
draw_sprite(sui_bookElements, 0, dx + 61, dy + 9);
draw_sprite(sui_bookElements, 0, dx + 82, dy + 7);

draw_sprite(sui_bookPages, 1, dx, dy);*/

/*
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_set_font(f_josefinSlab9);

draw_text(dx + 24, dy + 30, "I should make camp.");
draw_text(dx + 24, dy + 50, "Time for a journal entry.");
draw_text(dx + 24, dy + 70, "Options");
draw_text(dx + 24, dy + 90, "Quicksave and Quit");*/