if (iexists(o_dayNightCycle))
{
	//m_ambientColor = o_dayNightCycle.m_ambientLight;
	m_overlayColor = merge_color(o_dayNightCycle.m_overlayColor, c_gray, 0.5);
	
	m_ambientColor = merge_color(make_color_rgb(30, 17, 20), make_color_rgb(25, 25, 25), o_dayNightCycle.m_blendSunsetToDay);
	m_ambientColor = merge_color(m_ambientColor, make_color_rgb(11, 9, 26), o_dayNightCycle.m_blendSunsetToNight);
	
	m_ambientIndoors = true;
}