/// @description perform cutscene

var pl = getPlayer();

if (m_state == 0)
{
	if (pl.y < y)
	{
		questSetValue(kQidHarpyShadow, 5);
		m_state = 1;
	}
}
else if (m_state == 1)
{
	if (!exists(o_cts00_FeatherDropProp))
	{
		new(o_cts00_FeatherDropProp);
		o_cts00_FeatherDropProp.xstart = x;
		o_cts00_FeatherDropProp.y = y - 240;
	}
	else
	{
		if (o_cts00_FeatherDropProp.z_height <= 0)
		{
			m_state = 2;
		}
	}
}
else if (m_state == 2)
{
	var feather = new(o_pickupJunk_CoolFeather);
		feather.x = o_cts00_FeatherDropProp.x;
		feather.y = o_cts00_FeatherDropProp.y;
		feather.z_height = o_cts00_FeatherDropProp.z;
	delete(o_cts00_FeatherDropProp);
	
	m_state = 3;
}
else if (m_state == 3)
{
	if (!exists(o_pickupJunk_CoolFeather))
	{
		questSetValue(kQidHarpyShadow, 10);
		m_state = 4; // done
		delete(this);
	}
}