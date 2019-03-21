if (exists(collision_rectangle(x, y, x + 16, y + 16, ob_areaWater, true, false)))
{
	m_isSource = true;
	m_waterLevel = 4;
}
else
{
	m_isSource = false;
}

// Check for water sources if not a source
if (!m_isSource)
{
	// Check to the left, right, up, and down
	var checkx = array_create(4, 0);
	var checky = array_create(4, 0);
	var checkresult = array_create(4, null);
	checkx[0] = 16;
	checky[1] = -16;
	checkx[2] = -16;
	checky[3] = 16;
	for (var i = 0; i < 4; ++i)
	{
		checkresult[i] = collision_point(x + 8 + checkx[i], y + 8 + checky[i], o_miniCanalWater, false, true);
	}
	
	// Now grab the biggest water level
	var waterSource = 0;
	for (var i = 0; i < 4; ++i)
	{
		if (exists(checkresult[i]))
		{
			waterSource = max(waterSource, checkresult[i].m_waterLevel);
		}
	}
	
	// Now set the water level
	m_waterLevel = max(0, waterSource - 1);
}