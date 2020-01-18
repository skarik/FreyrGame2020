var supply_source = argument0;
var __unused_supply_target = argument1;
if (!supply_source.m_powerMathSaturate)
	return 1.0 - supply_source.m_powerOutput;
else
	return saturate(1.0 - supply_source.m_powerOutput);