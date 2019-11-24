/// @description Collect item

if (exists(m_user) && m_user.id == o_PlayerTest.id)
{
	// Deposit an item
	instance_create_depth(m_user.x, m_user.y, depth - 14, m_pickup);
	
	// Decrement the junk we have
	image_index -= 1;
	if (image_index == 0)
	{
		m_usable = false;
	}
}