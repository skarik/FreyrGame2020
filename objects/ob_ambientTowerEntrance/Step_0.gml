if (iexists(o_dayNightCycle))
{
	//m_ambientColor = o_dayNightCycle.m_ambientLight;
	m_overlayColor = o_dayNightCycle.m_overlayColor;
	
	m_ambientColor = merge_color(make_color_rgb(30, 17, 20), make_color_rgb(25, 25, 25), o_dayNightCycle.m_blendSunsetToDay);
	m_ambientColor = merge_color(m_ambientColor, make_color_rgb(9, 7, 26), o_dayNightCycle.m_blendSunsetToNight);
	
	var positional_blend = getPlayer().y / room_height;
	
	// Lighten the ambient as we get higher.
	m_ambientColor = merge_color(m_ambientColor, c_black, positional_blend);
	// Spike the bloom as we get higher
	m_bloomDropOffset = lerp(-0.15,-0.10, positional_blend) + 0.25;
	m_bloomMulOffset  = lerp( 1.80,-0.20, positional_blend) - 0.05;
	
	// Use indoor character lighting rules
	m_ambientIndoors = true;
	
	// and we want to use wide palette
	paletteSetCurrent(kPaletteWide);
}