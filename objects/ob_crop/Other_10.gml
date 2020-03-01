/// @description CoNsUmE DiRt

if (cropIsMature(this))
{
	repeat (m_itemDropCount)
	{
		instance_create_depth(x,y, depth, m_itemDrop);
	}

	// TODO: do particles when harvesting!

	if (exists(m_dirt))
	{
		m_dirt.planted = false;
		m_dirt.tilled = false;
		//m_dirt.watered = false;
		m_dirt.m_sprIndexUntilled = choose(2, 3, 4, 5);
	}

	delete(this);
}