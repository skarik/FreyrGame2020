/// @description Vendor update

if (!iexists(m_player))
	m_player = getPlayer();
	
// Menu check:
if (m_player.m_currentVendor != null)
{
	m_totalBlend = min(1.0, m_totalBlend + Time.unscaledDeltaTime * 3.0);
}
else
{
	m_totalBlend = max(0.0, m_totalBlend - Time.unscaledDeltaTime * 3.0);
	if (m_totalBlend <= 0.0)
	{
		idelete(this);
		exit; // Skip the rest of the step if deleteed
	}
}

// Only do input if book is front & center
if (m_player.m_currentVendor != null || m_totalBlend == 1.0)
{
	controlUpdate(false);
}
else
{
	controlUpdate(true);
}

// Only do logic if book is front and center
if (m_player.m_currentVendor != null || m_totalBlend == 1.0)
{
	
}