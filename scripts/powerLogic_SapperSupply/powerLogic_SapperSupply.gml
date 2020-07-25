var supply_source = argument0;
var supply_target = argument1;

var supply_exists = false;
if (iexists(supply_source.m_powerSapper))
{
	if (object_get_base_parent(supply_source.m_powerSapper.object_index) == ob_spawner)
	{
		supply_exists = true;
		
		if (!iexists(supply_source.m_powerSapper.m_spawned_enemy) 
			|| supply_source.m_powerSapper.m_spawned_enemy.m_isDead
			|| supply_source.m_powerSapper.m_spawned_enemy.m_isKOed)
		{
			supply_exists = false;
		}
	}
	else
	{
		supply_exists = true;
	}
}

if (supply_target == supply_source.m_powerAlternateTarget)
{
	return supply_exists ? supply_source.m_powerOutput : 0.0;
}
else
{
	return supply_exists ? 0.0 : supply_source.m_powerOutput;
}