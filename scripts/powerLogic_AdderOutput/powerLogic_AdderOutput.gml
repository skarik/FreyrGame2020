function powerLogic_AdderOutput() {
	/*var supply_source = argument0;
	var __unused_supply_target = argument1;
	if (supply_source.m_powerMathMax)
		return max(supply_source.m_powerOutput, supply_source.m_powerSource2.m_powerOutput);
	else
		return saturate(supply_source.m_powerOutput + supply_source.m_powerSource2.m_powerOutput);*/
	//return m_powerInput;

	if (m_powerMathMax)
		return max(m_powerInput, m_powerSource2.m_powerOutput);
	else
		return saturate(m_powerInput + m_powerSource2.m_powerOutput);


}
