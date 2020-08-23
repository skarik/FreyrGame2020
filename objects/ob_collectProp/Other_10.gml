/// @description Collect item

if (iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	// Deposit an item
	instance_create_depth(m_user.x, m_user.y, depth - 14, m_pickup);
	
	// Decrement the junk we have
	image_index += 1;
	if (image_index == image_number - 1)
	{
		m_usable = false;
	}
}