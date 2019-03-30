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

// update book
if (canMove && !isBusyInteracting)
{
	if (xButton.pressed)
	{
		o_PlayerHud.m_book_enabled = !o_PlayerHud.m_book_enabled; // todo: make this a cutscene menu
	}
}

_playerInteractUsables();
_playerInteractCrops();
_playerInteractTillables();
//_playerInteractBuildables();
_playerInteractItems();