// Zero out the squad
m_aiGobbo_squad = array_create(0);

// We're creating a squad with self at the source
var source_gobbo = id;

// Locate squad nearby now:
var kMaxJoinDistance = 1024;
with (object_index)
{
	// Always add self
	if (id == source_gobbo)
	{
		source_gobbo.m_aiGobbo_squad[array_length_1d(source_gobbo.m_aiGobbo_squad)] = id;
		continue;
	}
	
	// Check for others nearby
	if (m_aiCombat_angry)
	{
		var dist = sqr(x - source_gobbo.x) + sqr(y - source_gobbo.y);
		if (dist < sqr(kMaxJoinDistance))
		{
			source_gobbo.m_aiGobbo_squad[array_length_1d(source_gobbo.m_aiGobbo_squad)] = id;
		}
	}
}

// Squad is now created. Call SetLeader to update.