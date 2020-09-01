/// @description fade out

// fade control
if (m_menuFadeLevel >= 0.0)
{
	if (controlAnyKey())
	{
		m_menuFade = true;
		inew_unique(o_ctsRig00_VSliceMenu);
	}
}

// Fade in
if (!m_menuFade)
{
	m_menuFadeLevel = min(0.0, m_menuFadeLevel + Time.deltaTime * 0.5);
}
// Fade out only menu
if (m_menuFade)
{
	m_menuOverlayOnlyFadeLevel = max(0.0, m_menuOverlayOnlyFadeLevel - Time.deltaTime * 0.5);
}

// Fade out
if (m_menuFullFade)
{
	yspeed -= 1000 * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	
	// Bring in fade level - which is used for animation
	m_menuFadeLevel += Time.deltaTime * 0.5;
	
	// If got to the end, let's continue.
	if (m_menuFadeLevel >= 1.0)
	{
		paletteSetCurrent(kPaletteCrushed);
		room_goto_next();
	}
}