controlUpdate(false);

inWater = exists(collision_point(x, y + 6, ob_areaWater, false, true))
	&& exists(collision_point(x - 5, y + 6, ob_areaWater, false, true))
	&& exists(collision_point(x + 5, y + 6, ob_areaWater, false, true))
	&& exists(collision_point(x, y + 6 - 4, ob_areaWater, false, true))
	&& exists(collision_point(x, y + 6 + 4, ob_areaWater, false, true));

var kMoveSpeed = 100;
if (inWater)
	kMoveSpeed *= 0.50;

xspeed = xAxis.value * kMoveSpeed;
yspeed = yAxis.value * kMoveSpeed;

// If motion is not stopped, check for some sliding angle stuff
if (sqr(xspeed) + sqr(yspeed) > 0)
{
	// If up ahread is a wall, see if we can rotate left or right
	var next_x = x + xspeed * Time.deltaTime;
	var next_y = y + yspeed * Time.deltaTime;
	if (place_meeting(next_x, next_y, ob_collider))
	{
		//var motionAngle = point_direction(0, 0, xspeed, yspeed);
		// this could be simplified if we just use cross product to get perpendicular offsets
		var motionCrossX = -yspeed;
		var motionCrossY = xspeed;
		var motionCrossLen = sqrt(sqr(motionCrossX) + sqr(motionCrossY));
		motionCrossX /= motionCrossLen;
		motionCrossY /= motionCrossLen;
		
		var kMaxSidestep = sprite_get_width(sprite_exists(mask_index) ? mask_index : sprite_index) * 0.75;
		var kMaxSidestepMovestep = 0.5;
		
		for (var i = 0; i <= kMaxSidestep; i += kMaxSidestepMovestep)
		{
			if (!place_meeting(next_x + motionCrossX * i, next_y + motionCrossY * i, ob_collider))
			{
				x += motionCrossX * min(i, kMoveSpeed * Time.deltaTime);
				y += motionCrossY * min(i, kMoveSpeed * Time.deltaTime);
				xspeed *= 1.0 - abs(motionCrossX);
				yspeed *= 1.0 - abs(motionCrossY);
				break;
			}
			if (!place_meeting(next_x - motionCrossX * i, next_y - motionCrossY * i, ob_collider))
			{
				x -= motionCrossX * min(i, kMoveSpeed * Time.deltaTime);
				y -= motionCrossY * min(i, kMoveSpeed * Time.deltaTime);
				xspeed *= 1.0 - abs(motionCrossX);
				yspeed *= 1.0 - abs(motionCrossY);
				break;
			}
		}
	}
}

// Check collision in the X direction
if (place_meeting(x + xspeed * Time.deltaTime, y, ob_collider))
{
	// Move contact
	move_contact_with(sign(xspeed), 0, ob_collider);
	// Stop motion
	xspeed = 0;
}

// Check collision in the Y direction
if (place_meeting(x, y + yspeed * Time.deltaTime, ob_collider))
{
	// Move contact
	move_contact_with(0, sign(yspeed), ob_collider);
	// Stop motion
	yspeed = 0;
}

// Limit max speed
var totalSpeed = sqrt(sqr(xspeed) + sqr(yspeed));
xspeed *= min(1.0, kMoveSpeed / totalSpeed);
yspeed *= min(1.0, kMoveSpeed / totalSpeed);

x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;


// update camera
camPlayerUpdate(x, y, xspeed, yspeed);