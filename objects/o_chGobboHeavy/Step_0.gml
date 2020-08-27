/// @description AI

// Inherit the parent event
event_inherited();

if (!m_aiCombat_alerted && !m_aiCombat_angry)
{
	aiGobboHeavyInit();
}