/// @description 

// Inherit the parent event
event_inherited();

m_team = kTeamBandit;
m_bloodType = kBloodStraw;
kKickbackAmount = 0.0;
m_canKnockout = false;
m_canDragOnKnockout = false;

// 3 hearts and 5 stamina bars, like gobbos
stats.m_health = 24.0;
stats.m_healthMax = stats.m_health;
stats.m_healthPrev = stats.m_health;
stats.m_stunMax = 5.0;

// Face downwards by default
facingDirection = 270;

// Revive timer for later
m_reviveTimer = 0;