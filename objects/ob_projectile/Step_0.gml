/// @description Motion & Collision

if (m_moving)
{
	var kMaxStep = 8.0;
	var speed_timed = sqrt(sqr(xspeed * Time.deltaTime) + sqr(yspeed * Time.deltaTime));
	var travel_direction = point_direction(0, 0, xspeed, yspeed);

	// Precalculate the step value so we dont keep hitting the trig
	var stepAmount_x = lengthdir_x(kMaxStep, travel_direction);
	var stepAmount_y = lengthdir_y(kMaxStep, travel_direction);
	var stepAmount_z = zspeed * Time.deltaTime / max(ceil(speed_timed / kMaxStep), 1.0);
	var final_zheight = z_height + zspeed * Time.deltaTime;
	
	var distance;
	for (distance = 0.0; distance + kMaxStep < speed_timed; distance += kMaxStep)
	{
		// Move the step distance
		x += stepAmount_x;
		y += stepAmount_y;
		z_height = max(0, z_height + stepAmount_z);
		// Do the collision check:
		event_user(0); // Collision check
	}
	// Move the last distance
	x += stepAmount_x / kMaxStep * (speed_timed - distance);
	y += stepAmount_y / kMaxStep * (speed_timed - distance);
	z_height = max(0, final_zheight);
	// Do the collision check:
	event_user(0); // Collision check
}