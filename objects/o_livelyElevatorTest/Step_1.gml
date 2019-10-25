/// @description update area & motion

// move up and down
if (place_meeting(x, y - z_height, o_PlayerTest))
{
	z_height += 16.0 * Time.deltaTime;
	image_index = 1;
}
else
{
	z_height -= 16.0 * Time.deltaTime;
	image_index = 0;
}

z_height = clamp(z_height, 0.0, 32.0);


// update eleavtion
m_elevation.x = x;
m_elevation.y = y - z_height;
platform3_set_z(m_elevation, z + z_height);