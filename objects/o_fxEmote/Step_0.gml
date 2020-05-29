/// @description set pos & update scale

if (iexists(o_PlayerHud))
{
	depth = o_PlayerHud.depth + 2;
}
if (iexists(m_target))
{
	x = m_target.x;
	y = m_target.y - m_target.sprite_height;
}

if (m_fadestate == 0)
{
	image_yscale = saturate(m_fade * 2.0);
	y -= sin(m_fade * 4.0) * 5.0 * (1.0 - m_fade);
	
	m_fade += Time.deltaTime * 4.0;
	if (m_fade >= 1.0)
	{
		m_fade = 1.0;
		m_fadestate = 1;
	}
}
else if (m_fadestate == 1)
{
	m_fadeWait += Time.deltaTime;
	if (m_fadeWait >= 1.0)
	{
		m_fadestate = 2;	
	}
}
else if (m_fadestate == 2)
{
	image_xscale = m_fade;
	
	m_fade -= Time.deltaTime * 4.0;
	if (m_fade <= 0.0)
	{
		idelete(this);
	}
}