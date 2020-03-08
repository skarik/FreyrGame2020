if (m_bag_totalBlend <= 0.01) exit;

surface_reset_target();
surface_set_target(m_surface);

var dx, dy;
//dx = (Screen.width / Screen.pixelScale) / 2;
dx = m_bag_alignright ? (GameCamera.width - 140) : 140;
dy = round(((Screen.height / Screen.pixelScale) - 160) * 1.0 - 16.0);
dy += (1.0 - bouncestep(smoothstep(m_bag_totalBlend))) * 120 + (1.0 - smoothstep(m_bag_totalBlend)) * 90;

var smooth_blend = smoothstep(m_sbag_blend);

var seedbag_scale_x = 1.0;
var seedbag_scale_y = 1.0;

var mainbag_scale_x = 1.0;
var mainbag_scale_y = 1.0;

var seedbag_x = dx + lerp(60, 0, smooth_blend) + smoothstep((0.5 - abs(0.5 - m_sbag_blend)) * 2.0) * 90.0;
var seedbag_y = dy + lerp(10, 0, smooth_blend);
var mainbag_x = dx - lerp(0, 60, smooth_blend) - smoothstep((0.5 - abs(0.5 - m_sbag_blend)) * 2.0) * 120.0;
var mainbag_y = dy + lerp(0, 10, smooth_blend);

var seedbag_index = 0;
var mainbag_index = 0;

if (m_sbag_blend < 0.05 && m_bag_totalBlend > 0.95)
	mainbag_index = 1;
if (m_sbag_blend > 0.95 && m_bag_totalBlend > 0.95)
	seedbag_index = 1;

if (m_sbag_blend < 0.5)
{
	draw_sprite_ext(sui_inventory_seedbag_0, seedbag_index,
					seedbag_x, seedbag_y,
					seedbag_scale_x, seedbag_scale_y,
					0.0,
					merge_color(c_ltgray, c_white, m_sbag_blend),
					1.0);
	draw_sprite_ext(sui_inventory_mainbag_0, mainbag_index,
					mainbag_x, mainbag_y,
					mainbag_scale_x, mainbag_scale_y,
					0.0,
					merge_color(c_white, c_ltgray, m_sbag_blend),
					1.0);
}
else
{
	draw_sprite_ext(sui_inventory_mainbag_0, mainbag_index,
					mainbag_x, mainbag_y,
					mainbag_scale_x, mainbag_scale_y,
					0.0,
					merge_color(c_white, c_ltgray, m_sbag_blend),
					1.0);
	draw_sprite_ext(sui_inventory_seedbag_0, seedbag_index,
					seedbag_x, seedbag_y,
					seedbag_scale_x, seedbag_scale_y,
					0.0,
					merge_color(c_ltgray, c_white, m_sbag_blend),
					1.0);
}

/*if (!m_sbag_seeds)
{
	var bag0_scalex = sprite_get_width(sui_inventory_bag_0_closed) / sprite_get_width(sui_inventory_bag_0);
	var bag0_scaley = sprite_get_height(sui_inventory_bag_0_closed) / sprite_get_height(sui_inventory_bag_0);
	
	var bag1_scalex = sprite_get_width(sui_inventory_bag_1) / sprite_get_width(sui_inventory_bag_1_closed);
	var bag1_scaley = sprite_get_height(sui_inventory_bag_1) / sprite_get_height(sui_inventory_bag_1_closed);
	
	// draw the unopened bag
	draw_sprite_ext(sui_inventory_seedbag_0, 0,
					dx + lerp(110, 0, smooth_blend),
					dy + lerp(10, 0, smooth_blend),
					lerp(1.0, bag1_scalex, smooth_blend),
					lerp(1.0, bag1_scaley, smooth_blend),
					0.0,
					merge_color(c_ltgray, c_white, m_sbag_blend),
					1.0);
	// draw current bag
	draw_sprite_ext(sui_inventory_mainbag_0, 0,
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
	draw_sprite_ext(sui_inventory_mainbag_0, 0,
					dx - lerp(0, 110, smooth_blend),
					dy + lerp(0, 10, smooth_blend),
					lerp(bag0_scalex, 1.0, smooth_blend),
					lerp(bag0_scaley, 1.0, smooth_blend),
					0.0,
					merge_color(c_white, c_ltgray, m_sbag_blend),
					1.0);
	// draw current bag
	draw_sprite_ext(sui_inventory_seedbag_0, 0,
					dx + lerp(110, 0, smooth_blend),
					dy + lerp(10, 0, smooth_blend),
					lerp(bag1_scalex, 1.0, smooth_blend),
					lerp(bag1_scaley, 1.0, smooth_blend),
					0.0,
					merge_color(c_ltgray, c_white, m_sbag_blend),
					1.0);
}*/

// draw everything in bag
var inventory = o_PlayerTest.inventory;

if (abs(m_sbag_blend - 0.5) > 0.45 && m_bag_totalBlend > 0.95)
{
	if (m_sbag_blend < 0.5)
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
			draw_sprite_ext(sui_inventory_box_0, 1,
							dx + dix, dy + diy,
							1.0, 1.0,
							0.0, c_white,
							1.0);
	
			if (item.object != null)
			{
				draw_sprite(object_get_sprite(item.object), 0, dx + dix + 15, dy + diy + 15);
				
				draw_set_color(c_white);
				draw_set_font(f_04b03);
				draw_set_halign(fa_right);
				draw_set_valign(fa_bottom);
				draw_text(dx + dix + 25, dy + diy + 25, string(item.count));
				
				// Run UI script
				if (item.onUi != itemNullUiScript)
				{
					var is_hovered = (i == m_bag_hover) || (i == m_bag_selection);
					script_execute(item.onUi, // Following are arguments for onUi
								   item.object,
								   dx + dix + 15, dy + diy + 15,
								   saturate( (is_hovered ? 1.0 : 0.0) ),
								   is_hovered, 
								   kItemUiCategoryBag);
					draw_set_alpha(1.0);
				}
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
		
		// draw the item we're hovering over
		if (m_bag_hover != null)
		{
			var item = bag[m_bag_hover];
			if (item.object != null)
			{
				var offset = m_bag_offsets[m_bag_hover];
				var dix = offset[0] - sprite_get_xoffset(sui_inventory_bag_0) - 5;
				var diy = offset[1] - 5;
				var dw = 76;
				
				draw_sprite_part(sui_choiceBox3, 0, 0,0,dw,20,			dx + dix + 30,		dy + diy);
				draw_sprite_part(sui_choiceBox3, 0, 250-dw,0,dw,20,		dx + dix + 30 + dw,	dy + diy);
				draw_sprite_part(sui_choiceBox3, 1, 0,0,dw,20,			dx + dix + 30,		dy + diy + 20);
				draw_sprite_part(sui_choiceBox3, 1, 250-dw,0,dw,20,		dx + dix + 30 + dw,	dy + diy + 20);
				draw_sprite_part(sui_choiceBox3, 1, 0,0,dw,20,			dx + dix + 30,		dy + diy + 40);
				draw_sprite_part(sui_choiceBox3, 1, 250-dw,0,dw,20,		dx + dix + 30 + dw,	dy + diy + 40);
				draw_sprite_part(sui_choiceBox3, 2, 0,0,dw,20,			dx + dix + 30,		dy + diy + 60);
				draw_sprite_part(sui_choiceBox3, 2, 250-dw,0,dw,20,		dx + dix + 30 + dw,	dy + diy + 60);
				
				// Draw item name & info as well
				draw_set_font(global.font_arvo8);
				draw_set_halign(fa_left);
				draw_set_valign(fa_top);
				draw_set_color(c_gold);
				draw_text_spaced(dx + dix + 36 + 1, dy + diy + 4 + 1, item.name, 2);
				draw_set_color(c_black);
				draw_text_spaced(dx + dix + 36, dy + diy + 4, item.name, 2);
				
				//
				var temp_item = new(item.object);
				draw_set_font(global.font_arvo7);
				draw_set_color(c_gold);
				draw_text_spaced_wrap(dx + dix + 36 + 1, dy + diy + 19 + 1, temp_item.m_description, 2, dw * 2 - 11 * 3);
				draw_set_color(c_black);
				draw_text_spaced_wrap(dx + dix + 36, dy + diy + 19, temp_item.m_description, 2, dw * 2 - 11 * 3);
				delete(temp_item);
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
			draw_sprite_ext(sui_inventory_box_0, 1,
							dx + dix, dy + diy,
							1.0, 1.0,
							0.0, c_white,
							1.0);
	
			if (item.object != null)
			{
				draw_sprite(object_get_sprite(item.object), 0, dx + dix + 15, dy + diy + 15);
				
				draw_set_color(c_white);
				draw_set_font(f_04b03);
				draw_set_halign(fa_right);
				draw_set_valign(fa_bottom);
				draw_text(dx + dix + 25, dy + diy + 25, string(item.count));
				
				// Run UI script
				if (item.onUi != itemNullUiScript)
				{
					var is_hovered = (i == m_seed_hover) || (i == m_seed_selection);
					script_execute(item.onUi, // Following are arguments for onUi
								   item.object,
								   dx + dix + 15, dy + diy + 15,
								   saturate( (is_hovered ? 1.0 : 0.0) ),
								   is_hovered, 
								   kItemUiCategoryBag);
					draw_set_alpha(1.0);
				}
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