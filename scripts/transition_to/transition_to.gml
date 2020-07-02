// Then we go to the next room:
with (o_PlayerTest)
{
    if (!m_isPlayer) continue;
    
    persistent = true;
    inventory.persistent = true;
	camera.persistent = true;
	stats.persistent = true;
	quests.persistent = true;
	pstats.persistent = true;
	
	// update followers
	var pl_callee = id;
	for (var i = 0; i < 3; ++i)
	{
		with (pstats.m_party[i])
		{
			persistent = true;
			inventory.persistent = true;
			stats.persistent = true;
		}
	}
}
with (o_PlayerHud)
{
    persistent = true;
}
/*with (ob_character)
{
	if (m_isFollower)
	{
		persistent = true;
		inventory.persistent = true;
		stats.persistent = true;
	}
}*/
room_goto(argument0);
