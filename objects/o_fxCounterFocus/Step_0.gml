/// @description Update state

if (!m_cancelled)
{
	m_blend += Time.unscaledDeltaTime * 3.0;
	m_blend = saturate(m_blend);
}
else if (m_cancelled)
{
	m_blend -= Time.unscaledDeltaTime * 4.0;
	if (m_blend <= 0.0)
	{
		idelete(this);
	}
}