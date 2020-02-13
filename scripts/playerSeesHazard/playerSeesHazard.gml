/// @function playerSeesHazard(hazard)
/// @param hazard {Enum, kHazard}

var hazard = argument0;

var pl = getPlayer();
if (exists(pl))
{
	return pl.pstats.m_hazards[hazard] ? true : false;
}
return false;