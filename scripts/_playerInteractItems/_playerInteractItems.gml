var l_canMove = argument0;

var belt_object = inventory.belt_object[inventory.belt_selection];
var belt_count = inventory.belt_count[inventory.belt_selection];
var belt_name = inventory.belt_name[inventory.belt_selection];
var belt_checkUse = inventory.belt_checkUse[inventory.belt_selection];
var belt_onUse = inventory.belt_onUse[inventory.belt_selection];


if (belt_object != null)
{
	if (l_canMove
		&& (aButton.pressed || (isBlocking && bButton.pressed)))
	{
		if (script_execute(belt_checkUse))
		{
			script_execute(belt_onUse);
		}
	}
}