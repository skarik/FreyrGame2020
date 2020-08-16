/// @description 

idelete(o_menuVendorTrading); // Force delete vendor UI to kick back inventory "early"

event_inherited();

if (m_initialized)
{
	idelete(camera);
	idelete(hud);
	//idelete(quests);
	
	idelete(m_locatorLight);
}