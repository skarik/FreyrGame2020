var projectile = instance_create_depth(x, y, depth - 1, o_projectileTurnip);
projectile.xspeed = lengthdir_x(300, facingDirection);
projectile.yspeed = lengthdir_y(300, facingDirection);

_playerInteractItemDecrementBelt();