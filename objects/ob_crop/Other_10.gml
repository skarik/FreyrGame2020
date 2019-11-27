/// @description CoNsUmE DiRt

if (m_growValue >= m_growAmountMature)
{
	instance_create_depth(x,y, depth, m_itemDrop);

	if (exists(m_dirt))
	{
		m_dirt.planted = false;
		m_dirt.tilled = false;
		//m_dirt.watered = false;
	}

	delete(this);
}