/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

dropItems(kDropSeparateChances,[
	[o_pickupCons_ScorpStick, 0.33, 1],
	[o_pickupCons_HoneyAbsinthe, 0.25, 1],
]);

// Can passthru when we die
isPassthru = true;

// Do KO velocity
if (iexists(m_tookDamageSource))
{
	var ldir = point_direction(x, y, m_tookDamageSource.x, m_tookDamageSource.y);
	var lspeed = random_range(130, 230);
	
	zspeed = (300 - lspeed) * 0.5;
	xspeed = lengthdir_x(lspeed, ldir);
	yspeed = lengthdir_y(lspeed, ldir);
}