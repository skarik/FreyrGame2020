/// @function playerRevealHazard(hazard)
/// @param hazard {Enum, kHazard}

var hazard = argument0;
var tx = x;
var ty = y;

if (point_on_camera(tx, ty))
{
	var pl = getPlayer();
	if (iexists(pl))
	{
		if (!pl.pstats.m_hazards[hazard])
		{
			pl.pstats.m_hazards[hazard] = 1;
			// Create the UI graphic
			inew(o_uiNewMagicHazard);
		}
	}
}