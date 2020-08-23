/// @description On thrown

if (iexists(m_user))
{
	// get throwing direction
	var throwing_direction = [m_user.xAxis.value, m_user.yAxis.value];
	if (avec2_sqrlength(throwing_direction) < 0.04)
	{
		throwing_direction = [m_user.xspeed, m_user.yspeed];
	}
	
	throwing_direction = avec2_normalized(throwing_direction); // TODO: analog support for throwing?

	// set velocity
	/*xspeed = throwing_direction[0] * 250;
	yspeed = throwing_direction[1] * 250;
	zspeed = 40;*/
	
	var projectile = instance_create_depth(x, y, depth, ob_projectileYeetedPot);
		projectile.z = z;
		projectile.z_height = z_height;
		projectile.xspeed = throwing_direction[0] * 250;
		projectile.yspeed = throwing_direction[1] * 250;
		projectile.zspeed = 40;
		projectile.m_potInstance = id;
		projectile.sprite_index = sprite_index;
		projectile.image_index = image_index;
		projectile.m_owner = m_user;
	
	instance_deactivate_object(id);
}

// go into throwing state
/*m_moving = true;
m_usable = false;*/