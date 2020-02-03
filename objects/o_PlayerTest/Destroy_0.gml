/// @description 

event_inherited();

if (m_initialized)
{
	delete(camera);
	delete(hud);
	delete(quests);
}

delete(m_locatorLight);