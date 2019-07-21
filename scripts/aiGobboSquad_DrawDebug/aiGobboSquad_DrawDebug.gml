if (m_aiGobbo_squadLeader == id || !exists(m_aiGobbo_squadLeader))
{
	// Draw all the debug info for the squad
	var c_debug = c_lime;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(f_04b03);
	
	for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
	{
		var gobbo = m_aiGobbo_squad[i];
		if (exists(gobbo))
		{
			with (gobbo)
			{
				draw_set_color(c_debug);
				draw_circle(x, y, 10, true);
				draw_text(x + 8, y + 20, string(m_aiGobbo_squadMember));
				draw_text(x + 8, y + 28, string(m_aiGobbo_squadAge));
				if (m_aiCombat_alerted)
					draw_text(x - 20, y + 20, "ALERT");
				if (m_aiCombat_angry)
					draw_text(x - 20, y + 28, "ANGRY");
			}
		}
	}
	
	// Denote the squad leader
	if (exists(m_aiGobbo_squadLeader))
	{
		draw_set_color(c_debug);
		draw_circle(m_aiGobbo_squadLeader.x, m_aiGobbo_squadLeader.y, 15, true);
		draw_circle(m_aiGobbo_squadLeader.x, m_aiGobbo_squadLeader.y, 18, true);
	}
}