// Inherit the parent event
event_inherited();

// do hidden code
isHidden = false;
if (position_meeting(x, y, ob_areaTallGrass)
	&& position_meeting(x - 7, y, ob_areaTallGrass) && position_meeting(x + 7, y, ob_areaTallGrass)
	&& position_meeting(x, y - 4, ob_areaTallGrass) && position_meeting(x, y + 4, ob_areaTallGrass))
{
	isHidden = true;
}
