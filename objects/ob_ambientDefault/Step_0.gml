if (exists(o_dayNightCycle))
{
	m_ambientColor = o_dayNightCycle.m_ambientLight;
	m_overlayColor = o_dayNightCycle.m_overlayColor;
	
	if (timeofdayGetDay() < 5)
		paletteSetCurrent(kPaletteCrushed);
}