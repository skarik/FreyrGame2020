function powerLogic_SubtractOutput() {
	if (m_powerMathMin)
		return min(m_powerInput, m_powerSource2.m_powerOutput);
	else
		return saturate(m_powerInput - m_powerSource2.m_powerOutput);


}
