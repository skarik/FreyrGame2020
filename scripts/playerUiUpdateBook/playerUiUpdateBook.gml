//m_book_enabled

if (o_PlayerTest.m_usingBook)
{
	m_book_totalBlend = min(1.0, m_book_totalBlend + Time.deltaTime * 3.0);
}
else
{
	m_book_totalBlend = max(0.0, m_book_totalBlend - Time.deltaTime * 3.0);
}