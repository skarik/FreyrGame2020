/// @description Test power, run spawner

var active = m_active;

// Check for power preventing pots from spawning
if (exists(m_powerSource))
{
	if (m_powerSource.m_powerOutput < 0.5)
	{
		active = false;
	}
}

// Spawn pots when player nearby
var pl = getPlayer();
if (exists(pl))
{
	if (point_distance(x, y, pl.x, pl.y) > 128)
	{
		active = false;
	}
}

// Spawn if we can and pot has not been consumed.
if (active)
{
	if (!exists(m_pot) || m_pot.energyPlugged)
	{
		m_pot = instance_create_depth(x, y, depth, o_potEnergy);
	}
}