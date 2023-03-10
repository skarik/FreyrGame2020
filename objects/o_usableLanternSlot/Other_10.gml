/// @description Interacting with mechanism

if (m_usable && iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!m_lanternPlaced)
	{
		if (getPlayerHasItem(kPitemLantern))
		{
			playerRemovePitem(kPitemLantern);
			m_lanternPlaced = true;
			
			m_lanternProp = instance_create_depth(x, y, depth - 4, o_pickupTool_Lantern);
			m_lanternProp.m_canPickUp = false;
			
			if (!iexists(m_gearTockSfx))
				m_gearTockSfx = sound_play_at(x, y, "audio/door/tock0.wav");
			m_gearTockSfx.loop = true;
			m_gearTockSfx.pitch = 0.66;
		}
	}
	else
	{
		idelete(m_lanternProp);
		m_lanternPlaced = false;
		
		var lanternPickup = instance_create_depth(m_user.x, m_user.y, m_user.depth + 100, o_pickupTool_Lantern);
			lanternPickup.m_showPickupUI = false;
			lanternPickup.m_pickupTimer = 1.0;
	}
}