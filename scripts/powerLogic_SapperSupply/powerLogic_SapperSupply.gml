var supply_source = argument0;
var supply_target = argument1;

if (supply_target == supply_source.m_powerAlternateTarget)
{
	return exists(supply_source.m_powerSapper) ? supply_source.m_powerOutput : 0.0;
}
else
{
	return exists(supply_source.m_powerSapper) ? 0.0 : supply_source.m_powerOutput;
}