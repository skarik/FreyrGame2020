/// @description On put down

event_inherited();

var inPlug = false;
var inPlugId = null;

// Check if in plug...
if (exists(m_user))
{
	var pot = id;
	with (o_livelyPoweredPotPlug)
	{
		if (point_distance(x, y, pot.x, pot.y) < 16
			|| point_distance(x, y,
							  pot.m_user.x + lengthdir_x(10, pot.m_user.facingDirection),
							  pot.m_user.y + lengthdir_y(10, pot.m_user.facingDirection)) < 16)
		{
			inPlug = true;
			inPlugId = id;
			m_pot = pot;
			break;
		}
	}
}


if (inPlug)
{
	// Placed in a power slot? Save!
	x = inPlugId.x;
	y = inPlugId.y;
	energyPlugged = true;
	
	m_canPickUp = false;
	energyFade = false;
	m_name = "Plugged Energy Pot";
	m_actionName = "";
}
else
{
	// Not placed in a power slot? Destroy self.
	m_canPickUp = false;
	energyFade = true;
	m_name = "Decaying Energy Pot";
	m_actionName = "";
}