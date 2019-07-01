var tx = argument0;
var ty = argument1;
var tdir = argument2;

var poof;

/*for (var dir = 0; dir < 270; dir += 180)
{
	poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
	poof.m_xspeed = lengthdir_x(80.0, dir);
	poof.m_yspeed = lengthdir_y(80.0, dir);
	poof.m_friction = 160.0;
	poof.m_life = 1.0;
	poof.m_size = 16.0;
	poof.image_blend = c_gray;
}*/

repeat (3)
{
	poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
	poof.m_direction = random(360);
	poof.m_xspeed = lengthdir_x(20.0, poof.m_direction) + lengthdir_x(20.0, tdir + 180);
	poof.m_yspeed = lengthdir_y(20.0, poof.m_direction) + lengthdir_x(20.0, tdir + 180);
	poof.m_friction = 150.0;
	poof.m_life = 0.3;
	poof.m_size = 4.0;
	poof.image_blend = c_gray;
}