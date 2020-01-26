/// @description Update ranges

m_livliness -= Time.deltaTime / 7.0;

if (m_livliness > 0.0)
{
	m_range = motion1d_to(m_range, 32 + 64 * m_strength, Time.deltaTime * 64.0);
}
else
{
	m_range -= Time.deltaTime * 8.0;
	if (m_range < 0.0)
		delete(this);
}