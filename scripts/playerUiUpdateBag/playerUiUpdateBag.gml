if (o_PlayerTest.m_usingInventory)
{
	m_bag_totalBlend = min(1.0, m_bag_totalBlend + Time.unscaledDeltaTime * 3.0);
}
else
{
	m_bag_totalBlend = max(0.0, m_bag_totalBlend - Time.unscaledDeltaTime * 3.0);
}

// update sbag blend
if (m_sbag_seeds)
{
	m_sbag_blend = min(1.0, m_sbag_blend + Time.unscaledDeltaTime * 5.0);
}
else
{
	m_sbag_blend = max(0.0, m_sbag_blend - Time.unscaledDeltaTime * 5.0);
}

// update offsets
camPlayerSetCenterOffset((m_bag_alignright ? +1 : -1) * smoothstep(m_bag_totalBlend) * 160, 0.0);

if (o_PlayerTest.m_usingInventory)
{
	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_bag_hover = null;
		m_seed_hover = null;
	}
	
	// Update the mouse-over for main bag
	if (!m_sbag_seeds)
	{
		var bag_size = array_length_1d(m_bag_offsets);
		for (var i = 0; i < bag_size; ++i)
		{
			var offset = m_bag_draw_rects[i];
			var box_x = offset[0];
			var box_y = offset[1];
		
			if (cursor_x >= box_x && cursor_x <= box_x + 20
				&& cursor_y >= box_y && cursor_y <= box_y + 20)
			{
				m_bag_hover = i;
				break;
			}
		}
		m_seed_hover = null;
	}
	// Update the mouse-over for seed bag
	else
	{
		var seed_size = array_length_1d(m_seed_offsets);
		for (var i = 0; i < seed_size; ++i)
		{
			var offset = m_seed_draw_rects[i];
			var box_x = offset[0];
			var box_y = offset[1];
		
			if (cursor_x >= box_x && cursor_x <= box_x + 20
				&& cursor_y >= box_y && cursor_y <= box_y + 20)
			{
				m_seed_hover = i;
				break;
			}
		}
		m_bag_hover = null;
	}
	// UVdir controls under InventoryManagement
}
else
{
	m_bag_hover = null;
	m_bag_selection = null;
	
	m_seed_hover = null;
	m_seed_selection = null;
}