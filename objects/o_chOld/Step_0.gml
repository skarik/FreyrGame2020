/// @description follow player

m_isDead = false;
m_isKOed = false;
stats.m_health = stats.m_healthMax;

//aiFollowerUpdate();
aiScriptableUpdate();

// Do ground motion
event_inherited();