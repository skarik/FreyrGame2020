var _itemType = argument0;

var projectile = instance_create_depth(x, y, depth - 1, o_projectileTurnip);
	projectile.xspeed = lengthdir_x(300, aimingDirection);
	projectile.yspeed = lengthdir_y(300, aimingDirection);
	projectile.m_owner = id;
	projectile.m_team = m_team;

_playerInteractItemDecrementBelt();