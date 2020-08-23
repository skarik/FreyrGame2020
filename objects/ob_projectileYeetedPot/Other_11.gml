/// @description On Hit Character

//m_moving = false;

// Make sure fuse is almost about to blow
/*m_fuseTimer = min(m_fuseTimer, 0.5);

// Switch to large sprite
sprite_index = s_projectileBombBig;*/

xspeed *= 0.1;
yspeed *= 0.1;
zspeed = min(zspeed, zspeed * 0.1);