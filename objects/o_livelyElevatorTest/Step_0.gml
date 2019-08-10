/// @description update area & motion
exit;

// move up and down
if (place_meeting(x, y, o_PlayerTest))
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
m_elevation.z = z - z_height;