/// @description Check source

if (exists(m_source))
{
	if (m_source.m_isDead)
	{
		delete(this);
	}
}