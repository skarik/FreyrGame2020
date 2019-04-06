event_inherited();

// animation update
playerAnimLateUpdate();

// usable & combat update
playerInteractEndStep();

/// water shit
if (inWater)
{
	z_height = -4;
}
else
{
	z_height = max(0, z_height);
}