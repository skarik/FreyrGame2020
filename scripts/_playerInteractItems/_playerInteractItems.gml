var l_canMove = argument0;

var belt = inventory.belt[inventory.belt_selection];

if (belt.object != null)
{
	if (l_canMove
		&& (aButton.pressed || (isBlocking && bButton.pressed)))
	{
		if (script_execute(belt.checkUse))
		{
			script_execute(belt.onUse);
		}
	}
}