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
	if (!iexists(o_cts00_FeatherDropProp))
	{
		inew(o_cts00_FeatherDropProp);
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
	var feather = inew(o_pickupJunk_CoolFeather);
		feather.x = o_cts00_FeatherDropProp.x;
		feather.y = o_cts00_FeatherDropProp.y;
		feather.z_height = o_cts00_FeatherDropProp.z;
	idelete(o_cts00_FeatherDropProp);
	
	m_state = 3;
}
else if (m_state == 3)
{
	if (!iexists(o_pickupJunk_CoolFeather))
	{
		questSetValue(kQidHarpyShadow, 10);
		m_state = 4; // done
		idelete(this);
	}
}