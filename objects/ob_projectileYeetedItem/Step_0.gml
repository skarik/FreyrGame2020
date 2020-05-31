/// @description Motion, collision, & visuals

// Inherit the parent event
event_inherited();

sprite_index = object_get_sprite(m_itemObject);

if (m_moving)
{
	zspeed -= zgravity * Time.deltaTime;
}
else
{
	var item = instance_create_depth(x, y, depth - 1, m_itemObject);
		item.z = z;
		item.z_height = z_height;
		
	idelete(this);
}