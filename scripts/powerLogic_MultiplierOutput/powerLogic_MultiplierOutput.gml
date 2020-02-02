if (m_powerSource2 != null && exists(m_powerSource2))
{
	if (!m_powerMathSaturate)
		return m_powerInput * m_powerSource2.m_powerOutput;
	else
		return saturate(m_powerInput * m_powerSource2.m_powerOutput);
}
else
{
	if (!m_powerMathSaturate)
		return m_powerInput * m_powerSourceConstant;
	else
		return saturate(m_powerInput * m_powerSourceConstant);
}