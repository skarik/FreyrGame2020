/// @description Update the fades

// Update depth
if (exists(o_PlayerHud))
{
	depth = o_PlayerHud.depth - 1; // Just over the HuD
}

// Fading in
if (m_fadeState == 0)
{
	m_timer += Time.deltaTime / kFadeInTime;
	if (m_timer >= 1.0)
	{
		m_timer = 0.0;
		m_fadeState = 1;
	}
}
// Holding on screen
else if (m_fadeState == 1)
{
	m_timer += Time.deltaTime / kHoldTime;
	if (m_timer >= 1.0)
	{
		m_timer = 0.0;
		m_fadeState = 2;
	}
}
// Fading off the screen
else if (m_fadeState == 2)
{
	m_timer += Time.deltaTime / kFadeOutTime;
	if (m_timer >= 1.0)
	{
		delete(this);
	}
}