/// @description If angry or alerted, check children for reducing state

if (m_aiAngry || m_aiAlerted)
{
	var checking_area = id;
	var still_alerted = false;
	var still_angry = false;
	
	m_livePopulation = 0; // Reset population count.
	
	with (o_chGobboTest)
	{
		if (m_isDead || m_isKOed)
		{
			continue;
		}
		if (m_aialert_area == checking_area)
		{
			checking_area.m_livePopulation += 1; // Live, add to the population count
			
			// Check if should deaggro...
			if (m_aiCombat_angry)
			{
				still_angry = true;
			}
			if (m_aiCombat_alerted)
			{
				still_alerted = true;
			}
			
			// Stop checking if hit break case
			if (still_angry && still_alerted)
			{
				break;
			}
		}
	}
	
	m_aiAngry = still_angry;
	m_aiAlerted = still_alerted;
}