/// @description Init and default stuff

xspeed = 0;
yspeed = 0;
zspeed = 0;
depthInit();
z_height = 16;

m_owner = null;
m_team = kTeamNone;
m_damage = 1.0;
m_damageType = kDamageTypeBlunt;
m_isPlayer = false;

m_moving = true;
m_collisionIsForWall = false;

// Fallback for when the character dies before hit (or no character sourced)
isBlocking = false;
isDashing = false;
isEthereal = false;