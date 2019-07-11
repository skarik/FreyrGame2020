var tx = argument0;
var ty = argument1;

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
if (!areaInWater(x, y))
{
	for (var dir = 0; dir < 360; dir += 60)
	{
		poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
		poof.m_direction = dir;
		poof.m_xspeed = lengthdir_x(40.0, poof.m_direction);
		poof.m_yspeed = lengthdir_y(40.0, poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 6.0;
		poof.image_blend = c_ltgray;
	}
	repeat (3)
	{
		poof = instance_create_depth(tx, ty, depth - 1, o_ptcDustPoof);
		poof.m_direction = random(360);
		poof.m_xspeed = lengthdir_x(40.0, poof.m_direction);
		poof.m_yspeed = lengthdir_y(40.0, poof.m_direction);
		poof.m_friction = 80.0;
		poof.m_life = 0.9;
		poof.m_size = 11.0;
		poof.image_blend = c_ltgray;
	}
}