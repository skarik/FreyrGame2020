// Then we go to the next room:
with (o_PlayerTest)
{
    if (!m_isPlayer) continue;
    
    persistent = true;
    inventory.persistent = true;
	stats.persistent = true;
}
with (o_PlayerHud)
{
    persistent = true;
}
room_goto(argument0);
