/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (!m_isDead)
{
	if (m_turnipTimer > 4.0)
	{
		m_turnipTimer -= 4.0;
		
		// take aim...
		var predict_x = o_PlayerTest.x;
		var predict_y = o_PlayerTest.y;
		// get the distance to do very rough aiming correction
		var distance = point_distance(x, y, predict_x, predict_y);
		var predictScalar = distance / 300;
		predict_x += o_PlayerTest.xspeed * predictScalar;
		predict_y += o_PlayerTest.yspeed * predictScalar;
		
		// ..and throw a turnip!
		var aimingDirection = point_direction(x, y, predict_x, predict_y) + random_range(-5, 5);
		var projectile = instance_create_depth(x, y, depth - 1, o_projectileTurnip);
			projectile.xspeed = lengthdir_x(300, aimingDirection);
			projectile.yspeed = lengthdir_y(300, aimingDirection);
			projectile.m_owner = id;
			projectile.m_team = m_team;
	}

	m_turnipTimer += Time.deltaTime;
}