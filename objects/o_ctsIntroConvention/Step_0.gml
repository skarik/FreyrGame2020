/// @description fade out

if (controlAnyKey())
{
	m_menuFade = true;
}

if (!m_menuFade)
{
	m_musicDelay += Time.deltaTime;
	if (m_musicDelay > 2.0)
	{
		if (!iexists(o_mus00_AnimeCts))
		{
			inew(o_mus00_AnimeCts);
			o_mus00_AnimeCts.m_trackVolume[0] = 1.0 * m_musicGain;
		}
	}
}

if (m_menuFade)
{
	yspeed -= 1000 * Time.deltaTime;
	y += yspeed * Time.deltaTime;
	
	if (iexists(o_mus00_AnimeCts))
	{
		o_mus00_AnimeCts.m_trackVolume[0] = saturate(1.0 + y / 1000) * m_musicGain;
	}
	
	if (y < -1600)
	{
		idelete(o_mus00_AnimeCts);
		paletteSetCurrent(kPaletteCrushed);
		room_goto_next();
	}
}