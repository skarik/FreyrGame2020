var projectile = instance_create_depth(x, y, depth - 1, ob_projectileYeetedItem);
	projectile.z = z;
	projectile.z_height = 24;
	projectile.m_itemObject = m_moveChargeItem;
	projectile.xspeed = lengthdir_x(400 * m_moveCharge, aimingDirection);
	projectile.yspeed = lengthdir_y(400 * m_moveCharge, aimingDirection);
	projectile.m_owner = id;
	projectile.m_team = m_team;

_playerInteractItemDecrementBelt();

moScriptOverride = null;
m_moveCharge = 0.0;