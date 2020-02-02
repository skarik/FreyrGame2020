var supply_source = argument0;
var __unused_supply_target = argument1;
if (supply_source.m_powerMathMin)
	return min(supply_source.m_powerOutput, supply_source.m_powerSource2.m_powerOutput);
else
	return saturate(supply_source.m_powerOutput - supply_source.m_powerSource2.m_powerOutput);