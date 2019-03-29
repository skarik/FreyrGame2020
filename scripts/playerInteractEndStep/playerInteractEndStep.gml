if (cButton.down && !m_isHolding && !m_isTilling && !m_isPlanting)
{
	isBlocking = true;
}
else
{
	isBlocking = false;
}

if (canMove && !isBusyInteracting)
{
	if (lButton.pressed)
	{
		inventory.belt_selection -= 1;
		if (inventory.belt_selection < 0) {
			inventory.belt_selection += inventory.belt_size;
		}
	}
	if (rButton.pressed)
	{
		inventory.belt_selection += 1;
		if (inventory.belt_selection >= inventory.belt_size) {
			inventory.belt_selection -= inventory.belt_size;
		}
	}
}

// update aiming
if (canMove && !isBusyInteracting)
{
	if (uPosition != uPositionPrevious || vPosition != vPositionPrevious)
	{
		aimingDirection = point_direction(x, y, uPosition, vPosition);
	}
}


_playerInteractUsables();
_playerInteractCrops();
_playerInteractTillables();
//_playerInteractBuildables();
_playerInteractItems();