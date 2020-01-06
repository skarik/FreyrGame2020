if (exists(o_dayNightCycle))
{
	//m_ambientColor = o_dayNightCycle.m_ambientLight;
	m_overlayColor = merge_color(o_dayNightCycle.m_overlayColor, make_color_rgb(128, 128, 128), 0.5);
	
	m_ambientColor = merge_color(make_color_rgb(30, 17, 20), make_color_rgb(25, 25, 25), o_dayNightCycle.m_blendSunsetToDay);
	m_ambientColor = merge_color(m_ambientColor, make_color_rgb(9, 7, 26), o_dayNightCycle.m_blendSunsetToNight);
	
	m_ambientColor = merge_color(m_ambientColor, make_color_rgb(25, 25, 25), 0.25);
	//var positional_blend = getPlayer().y / room_height;
	
	// Lighten the ambient as we get higher.
	//m_ambientColor = merge_color(m_ambientColor, c_black, positional_blend);
	// Spike the bloom as we get higher
	//m_bloomDropOffset = -0.10;
	//m_bloomMulOffset  = 1.80;
	
	//m_bloomDropOffset = -0.36;
	//m_bloomDropOffset = -0.17;
	m_bloomMulOffset  = 0.70;
	
	// do bloom changes based on lantern equipped
	var pl = getPlayer();
	var hasLantern = exists(pl.m_lanternProp);
	if (hasLantern)
		m_bloomDropOffset = min(-0.17 + 0.17, m_bloomDropOffset + Time.deltaTime * 0.2);
	else
		m_bloomDropOffset = max(-0.26 + 0.17, m_bloomDropOffset - Time.deltaTime * 0.2);

	// Use indoor character lighting rules
	m_ambientIndoors = true;
}