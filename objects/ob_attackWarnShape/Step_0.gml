/// @description Check source

if (iexists(m_source))
{
	if (m_source.m_isKOed)
	{
		idelete(this);
	}
}