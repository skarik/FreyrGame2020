if (iexists(o_dayNightCycle))
{
	var bIndoors = false;
	if (iexists(o_doodadHider_MithraTavern))
	{
		if (o_doodadHider_MithraTavern.image_alpha < 0.1)
		{
			bIndoors = true;
		}
	}
	
	m_indoorBlend = motion1d_to(m_indoorBlend, bIndoors ? 1.0 : 0.0, Time.deltaTime * 3.0);
	
	m_ambientColor = merge_color(o_dayNightCycle.m_ambientLight, make_color_rgb(127, 110, 90), m_indoorBlend);
	m_overlayColor = merge_color(o_dayNightCycle.m_overlayColor, c_gray, m_indoorBlend * 0.8);
}