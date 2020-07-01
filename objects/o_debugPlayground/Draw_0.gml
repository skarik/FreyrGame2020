/// @description Draw node state & cursor

with (ob_aiNode)
{
	event_user(0); // Render them nodes.
}

if (iexists(m_npc_selection))
{ 
	// Draw current command state
	if (m_npc_selection.m_aiScript_requestCommand == kAiRequestCommand_Move)
	{
		draw_sprite(
			sui_gearSmall, 0, 
			m_npc_selection.m_aiScript_requestPositionX,
			m_npc_selection.m_aiScript_requestPositionY);
	}
	
	// Draw character selector
	draw_sprite_ext(
		sui_arcaneSelect, 1,
		m_npc_selection.x, m_npc_selection.y - 3,
		1.0, -1.0,
		0.0,
		c_white,
		1.0);
}

{
	// Draw corner helpers
	var dx = GameCamera.view_x;
	var dy = GameCamera.view_y;
	
	draw_set_font(global.font_arvo7);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_black);
	draw_text(dx + 4, dy + 4, "1 - Spawn Nathan");
}

{
	// Draw cursor
	draw_sprite(sui_cursor, 0, uPosition, vPosition);
}
