/// @description Update player inputs
var pl = getPlayer();

if (iexists(pl))
{
	if (m_falling || pl.z_height > 16.0)
	{
		var pl_dist_sqr = sqr(x - pl.x) + sqr(y - pl.y);
		if ((m_mandatory && m_falling) || pl_dist_sqr < sqr(m_forceRadius))
		{
			// Move to the center
			var center_dir = point_direction(pl.x, pl.y, x, y);
			var center_dist = sqrt(pl_dist_sqr);
		
			// Stop motion if mandatory
			if (m_mandatory)
			{
				var pl_speed = sqrt(sqr(pl.xspeed) + sqr(pl.yspeed));
				var pl_dir = point_direction(0, 0, pl.xspeed, pl.yspeed);
				var pl_delta = min(pl_speed, 150.0 * Time.deltaTime);
			
				pl.xspeed -= lengthdir_x(pl_delta, pl_dir);
				pl.yspeed -= lengthdir_y(pl_delta, pl_dir);
			}
		
			var centering_speed = clamp(
				(1.0 - center_dist / m_forceRadius) * 2.0 * clamp((128 - pl.z_height) / 32, 0.5, 4.0),
				0.5,
				2.0);
		
			// Move player to the center
			var center_delta = min(center_dist, m_forceRadius *centering_speed * Time.deltaTime);
			pl.x += lengthdir_x(center_delta, center_dir);
			pl.y += lengthdir_y(center_delta, center_dir);
		
			m_falling = true;
		}
	}
	if (pl.z_height <= 0.0)
	{
		if (m_falling)
		{
			m_falling = false;
		
			// Do landing effect
			with (pl)
			{
				effectOnGroundHit(x, y);
			}
		}
	}
}