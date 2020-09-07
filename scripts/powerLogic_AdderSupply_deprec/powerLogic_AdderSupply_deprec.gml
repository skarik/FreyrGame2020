function powerLogic_AdderSupply_deprec(argument0, argument1) {
	var supply_source = argument0;
	var __unused_supply_target = argument1;
	if (supply_source.m_powerMathMax)
		return max(supply_source.m_powerOutput, supply_source.m_powerSource2.m_powerOutput);
	else
		return saturate(supply_source.m_powerOutput + supply_source.m_powerSource2.m_powerOutput);


}
