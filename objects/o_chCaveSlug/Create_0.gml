/// @description Set up slime

// Inherit the parent event
event_inherited();

m_team = kTeamMonster;
m_bloodType = kBloodWhite;

stats.m_health = 12.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;

m_aiState_hangState = 0;

fxtimer_hangdropS = 0;
fxtimer_hangdrop = 0;