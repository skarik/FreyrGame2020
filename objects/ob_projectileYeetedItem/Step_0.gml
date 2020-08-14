/// @description Motion, collision, & visuals

// Inherit the parent event
event_inherited();

sprite_index = object_get_sprite(m_itemObject);

// Update on-ground check
if (z_height > 0)
{
	m_onGround = false;
}
else
{
	if (!m_onGround)
	{
		effectOnGroundHit(x, y);
	}
	m_onGround = true;
}

if (m_moving)
{
	zspeed -= zgravity * Time.deltaTime;
	if (m_onGround)
	{
		effectOnGroundStep(x, y, point_direction(0, 0, xspeed, yspeed));
	}
}
else
{
	var item = instance_create_depth(x, y, depth - 1, m_itemObject);
		item.z = z;
		item.z_height = z_height;
		
	idelete(this);
}