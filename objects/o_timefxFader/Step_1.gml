/// @description Do fading

if (m_fadeIn)
{
	m_multiplier = motion1d_to(m_multiplier, m_multiplierTarget, m_fadeSpeed * Time.unscaledDeltaTime);
}
else
{
	m_multiplier = motion1d_to(m_multiplier, 1.0, m_fadeSpeed * Time.unscaledDeltaTime);
	if (m_multiplier == 1.0)
	{
		idelete(this);
	}
}