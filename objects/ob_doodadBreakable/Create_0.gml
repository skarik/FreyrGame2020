/// @description Set health

// Inherit the parent event
event_inherited();


m_health = 1;
m_wasDestroyed = false;

// For the damage calculations
m_isPlayer = false;
m_team = 0;
isBlocking = false;
isDashing = false;
isEthereal = false;