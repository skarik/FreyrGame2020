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


_playerInteractUsables();
_playerInteractCrops();
_playerInteractTillables();
//_playerInteractBuildables();
_playerInteractItems();