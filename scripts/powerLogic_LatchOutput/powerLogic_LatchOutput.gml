function powerLogic_LatchOutput() {
	// Latch new value on input high
	if (iexists(m_powerLatchInput) && m_powerLatchInput.m_powerOutput > 0.5)
	{
		m_powerLatchValue = m_powerInput;
	}
	// Return saved value
	return m_powerLatchValue;


}
