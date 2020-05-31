var pl = getPlayer();
with (pl)
{
	if (m_checkpoint_valid)
	{
		x = m_checkpoint_x;
		y = m_checkpoint_y;
		if (room != m_checkpoint_room)
		{
			room_goto(m_checkpoint_room);
		}
	}
}