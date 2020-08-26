/// @description follow player

m_isDead = false;
m_isKOed = false;
stats.m_health = stats.m_healthMax;

//aiFollowerUpdate();
aiScriptableUpdate();

// Face at nearest character
var char = instance_nearest_notme(x, y, ob_characterGround);
if (iexists(char))
{
	facingDirection = point_direction(x, y, char.x, char.y)
}

// Do ground motion
event_inherited();