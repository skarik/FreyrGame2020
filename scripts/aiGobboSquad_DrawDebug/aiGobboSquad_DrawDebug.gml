if (m_aiGobbo_squadLeader == id || !iexists(m_aiGobbo_squadLeader))
{
	// Draw all the debug info for the squad
	var c_debug = c_lime;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(f_04b03);
	
	for (var i = 0; i < array_length_1d(m_aiGobbo_squad); ++i)
	{
		var gobbo = m_aiGobbo_squad[i];
		if (iexists(gobbo))
		{
			with (gobbo)
			{
				draw_set_color(c_debug);
				draw_circle(x, y, 10, true);
				
				// stun state
				if (m_isStunned) {
					draw_text(x - 20, y + 36, "STUNNED");
					draw_rectangle(x - 10, y - 10, x + 10, y + 10, true);
				}
				
				// squad state
				draw_text(x + 8, y + 20, string(m_aiGobbo_squadMember));
				draw_text(x + 8, y + 28, string(m_aiGobbo_squadAge));
				
				// AI state
				if (m_aiCombat_alerted)
					draw_text(x - 20, y + 20, "ALERT");
				if (m_aiCombat_angry)
					draw_text(x - 20, y + 28, "ANGRY");
					
				// Attacking state
				if (iexists(m_aiGobbo_squadLeader))
				{
					if (i == m_aiGobbo_squadLeader.m_aiGobbo_squadManage_Attacker)
					{
						draw_circle(x, y, 8.5, false);
						draw_circle(x, y, 40 - m_aiGobbo_squadStateTime * 20, true);
					}
				}
				
				// Attacking state 2
				if (m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHesitate
					|| m_aiGobbo_squadStateCase == kAiGobboSquadStateCase_AttackToHover)
				{
					var pl = getPlayer();
					draw_arrow(x, y, pl.x, pl.y, 7);
				}
				
				// Movement state
				draw_circle(m_aiGobbo_squadStateTargetPosition[0], m_aiGobbo_squadStateTargetPosition[1], 3 + sin(Time.time * 4.0), true);
				draw_arrow(x,
						   y,
						   lerp(x, m_aiGobbo_squadStateTargetPosition[0], 0.8),
						   lerp(y, m_aiGobbo_squadStateTargetPosition[1], 0.8),
						   4);
			}
		}
	}
	
	// Denote the squad leader
	if (iexists(m_aiGobbo_squadLeader))
	{
		with (m_aiGobbo_squadLeader)
		{
			draw_set_color(c_debug);
			draw_circle(x, y, 15, true);
			draw_circle(x, y, 18, true);
		}
	}
}