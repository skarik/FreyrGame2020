var day = argument0;

if (exists(o_weatherSystemRainstorm))
{
	if (o_weatherSystemRainstorm.m_strength > 0.1)
		return true;
}

return false; // this is WRONG lol