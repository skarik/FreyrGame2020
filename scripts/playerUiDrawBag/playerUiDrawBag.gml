if (m_bag_totalBlend <= 0.01) exit;

surface_reset_target();
surface_set_target(m_surface);

var dx, dy;
dx = (Screen.width / Screen.pixelScale) / 2;
dy = round(((Screen.height / Screen.pixelScale) - 160) * 1.0 - 16.0);
dy += (1.0 - bouncestep(smoothstep(m_bag_totalBlend))) * 100 + (1.0 - smoothstep(m_bag_totalBlend)) * 80;

draw_sprite(sui_inventory_bag_0, 0, dx, dy);

// draw everything in bag
var inventory = o_PlayerTest.inventory;
var bag = inventory.bag;
var bag_size = array_length_1d(bag);

var bag_offsets = [
	[28, 10], [52, 10], [76, 10], [100, 10], [124, 10], [148, 10], [172, 10],
	[28, 34], [52, 34], [76, 34], [100, 34], [124, 34], [148, 34], [172, 34],
	[28, 58], [52, 58], [76, 58], [100, 58], [124, 58], [148, 58], [172, 58],
			  [52, 82],									[148, 82]
];

var seed_offsets = [
	[23, 11], [47, 11], [71, 11], [95, 11], [119, 11], [143, 11], [172, 11],
	[23, 35], [47, 35], [71, 35], [95, 35], [119, 35], [143, 35], [172, 35],
	[23, 59], [47, 59], [71, 59], [95, 59], [119, 59], [143, 59], [172, 59]
];

draw_set_color(c_white);
draw_set_font(f_04b03);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

for (var i = 0; i < bag_size; ++i)
{
	var item = bag[i];
	var offset = bag_offsets[i];
	var dix = offset[0] - sprite_get_xoffset(sui_inventory_bag_0) - 5;
	var diy = offset[1] - 5;
	
	//draw_sprite(sui_bagBox, 0, dx + dix, dy + diy );
	
	if (item.object != null)
	{
		draw_sprite(object_get_sprite(item.object), 0, dx + dix + 15, dy + diy + 15);
		draw_text(dx + dix + 25, dy + diy + 25, string(item.count));
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