repeat (3)
{
	var poof = instance_create_depth(x, y - 4, depth - 1, o_ptcDustPoof);
	poof.m_direction = random(360);
	poof.m_xspeed = lengthdir_x(random_range(10.0, 40.0), poof.m_direction);
	poof.m_yspeed = lengthdir_y(random_range(10.0, 40.0), poof.m_direction);
	poof.m_friction = 80.0;
	poof.m_life = 0.9;
	poof.m_size = 13.0;
	poof.image_blend = c_ltgray;
}

if (exists(collider))
{
	delete(collider);
}
if (exists(light))
{
	delete(light);
}
if (exists(emissive))
{
	delete(emissive);
}