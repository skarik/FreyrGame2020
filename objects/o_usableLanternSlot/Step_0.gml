/// @description Update text if player has lantern or not

if (!m_lanternPlaced)
{
	if (getPlayerHasItem(kPitemLantern))
	{
		m_actionName = "Place Lantern";
	}
	else
	{
		m_actionName = "???";
	}
}
else
{
	m_actionName = "Grab Lantern";
}