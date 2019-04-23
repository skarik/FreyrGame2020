if (o_PlayerTest.m_usingInventory)
{
	m_bag_totalBlend = min(1.0, m_bag_totalBlend + Time.deltaTime * 3.0);
}
else
{
	m_bag_totalBlend = max(0.0, m_bag_totalBlend - Time.deltaTime * 3.0);
}

if (o_PlayerTest.m_usingInventory)
{
	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_bag_hover = null;
	}
	
	// Update the mouse-over 
	var bag_size = array_length_1d(m_bag_offsets);
	for (var i = 0; i < bag_size; ++i)
	{
		var offset = m_bag_offsets[i];
		//var dix = offset[0] - sprite_get_xoffset(sui_inventory_bag_0) - 5;
		//var diy = offset[1] - 5;
		var box_x = m_bag_base_x + offset[0];
		var box_y = m_bag_base_y + offset[1];
		
		if (cursor_x >= box_x && cursor_x <= box_x + 20
			&& cursor_y >= box_y && cursor_y <= box_y + 20)
		{
			m_bag_hover = i;
			break;
		}
	}
}
else
{
	m_bag_hover = null;
	m_bag_selection = null;
}