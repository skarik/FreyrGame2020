if (o_PlayerTest.m_usingInventory)
{
	m_bag_totalBlend = min(1.0, m_bag_totalBlend + Time.deltaTime * 3.0);
}
else
{
	m_bag_totalBlend = max(0.0, m_bag_totalBlend - Time.deltaTime * 3.0);
}