/*
m_chest_base_x = 0;
m_chest_base_y = 0;
m_chest_selection = null;
m_chest_hover = null;
*/

var chest = o_PlayerTest.m_currentChest;

if (chest != null && exists(chest))
{
	var cursor_x = round(o_PlayerTest.uPosition - (GameCamera.x - GameCamera.width / 2));
	var cursor_y = round(o_PlayerTest.vPosition - (GameCamera.y - GameCamera.height / 2));
	
	// reset if mouse move
	if (o_PlayerTest.uPosition != o_PlayerTest.uPositionPrevious
		|| o_PlayerTest.vPosition != o_PlayerTest.vPositionPrevious)
	{
		m_chest_hover = null;
	}
	
	// Update the mouse-over 
	var dspace = 20;
	for (var i = 0; i < max(1, inventoryGetCount(chest) + ((inventoryGetSize(chest) == kCountInfinite) ? 1 : 0)); ++i)
	{
		var box_x = m_chest_base_x;
		var box_y = m_chest_base_y + dspace * i + 8;
		
		if (cursor_x >= box_x && cursor_x <= box_x + 100
			&& cursor_y >= box_y && cursor_y <= box_y + dspace)
		{
			m_chest_hover = i;
			break;
		}
	}
}

// if not in inventory, clear selection
if (!o_PlayerTest.m_usingInventory)
{
	m_chest_selection = null;
}