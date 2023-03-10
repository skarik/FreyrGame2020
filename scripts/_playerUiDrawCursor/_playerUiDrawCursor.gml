function _playerUiDrawCursor() {
	// aimer
	var dx = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var dy = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));

	/*draw_set_color(c_black);
	draw_rectangle(dx - 3, dy - 1, dx + 3, dy + 1, false);
	draw_rectangle(dx - 1, dy - 3, dx + 1, dy + 3, false);
	draw_set_color(c_gold);
	draw_line(dx - 3, dy, dx + 2, dy);
	draw_line(dx, dy - 3, dx, dy + 2);*/
	draw_set_color(c_black);
	gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
	draw_sprite(sui_cursor, 0, dx-1, dy);
	draw_sprite(sui_cursor, 0, dx+1, dy);
	draw_sprite(sui_cursor, 0, dx, dy-1);
	draw_sprite(sui_cursor, 0, dx, dy+1);
	gpu_set_blendmode(bm_normal);
	draw_set_color(c_white);
	draw_sprite(sui_cursor, 0, dx, dy);

	// Draw current hand inventory as well
	if (o_PlayerTest.m_usingInventory)
	{
		if (m_held_inventory[0].object != null)
		{
			dx -= 4;
			dy -= 4;
		
			// Inventory bg
			draw_sprite(sui_inventory_box_0, 0, dx, dy);
		
			// Object sprite
			draw_sprite(object_get_sprite(m_held_inventory[0].object), 0, dx + 15, dy + 15);
		
			// Object count
			draw_set_color(c_white);
			draw_set_font(f_04b03);
			draw_set_halign(fa_right);
			draw_set_valign(fa_bottom);
			draw_text(dx + 25, dy + 26, string(m_held_inventory[0].count));
		}
	}


}
