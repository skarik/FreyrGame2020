/// @description camera noise

z = 6;
yrotation = -4 + sin(Time.time * 1.3) * 0.5;
zrotation = image_angle + sin(Time.time * 1.9) * 0.8;

if (iexists(o_ctsRig00_Logic))
{
	var t_cts = o_ctsRig00_Logic;
	if (t_cts.m_menuFadeLevel < 0.0)
	{
		z += sqr(saturate(abs(t_cts.m_menuFadeLevel))) * 20.0;
		//yrotation -= sqr(t_cts.m_menuFadeLevel) * 60.0;
		yrotation -= smoothstep(saturate(abs(t_cts.m_menuFadeLevel))) * 35.0;
	}
	else if (t_cts.m_menuFadeLevel > 0.0)
	{
		z -= sqr(t_cts.m_menuFadeLevel) * 3.0;
		yrotation += sqr(t_cts.m_menuFadeLevel) * 50.0;
	}
}