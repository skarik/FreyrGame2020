function _playerInteractItems(argument0) {
	var l_canMove = argument0;
	var belt;

	if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
		belt = inventory.belt[inventory.belt_selection];
	else
		belt = null;

	if (l_canMove
		&& (itemUseButton.pressed || (isBlocking && useButton.pressed)))
	{
		if (belt != null && belt.object != null)
		{
			if (belt.checkUse == itemNullScript || script_execute(belt.checkUse, belt.object))
			{
				script_execute(belt.onUse, belt.object);
			}
		}
		else
		{
			sound_play("audio/ui/use.wav");
		}
	}



}
