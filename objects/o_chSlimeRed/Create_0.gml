/// @description Set up slime

// Inherit the parent event
event_inherited();

m_team = kTeamMonster;
m_bloodType = kBloodNone;

stats.m_health = 5.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;