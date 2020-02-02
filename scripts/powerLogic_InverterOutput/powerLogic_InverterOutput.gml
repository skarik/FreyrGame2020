if (!m_powerMathSaturate)
	return 1.0 - m_powerInput;
else
	return saturate(1.0 - m_powerInput);