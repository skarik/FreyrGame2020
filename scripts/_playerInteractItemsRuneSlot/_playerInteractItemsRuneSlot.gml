function _playerInteractItemsRuneSlot(argument0) {
	var l_canMove = argument0;

	if (l_canMove && !m_isHolding && !m_isPlanting && !isDashing && !isBlocking && !isAttacking && !isBusyInteracting)
	{
		if (runeButton.pressed)
		{
			if (false)
			{
			}
			else
			{
				sound_play("audio/ui/use.wav");
			}
		}
	}


}
