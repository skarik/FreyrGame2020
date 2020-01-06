/// @description flutter

var xtarget = o_PlayerTest * 0.5;
var ytarget =  o_PlayerTest * 1.5;

// If far from a turnip, fly to one
if (point_distance(x, y, xtarget, ytarget) > 20)
{
	var steer_direction = point_direction(x, y, xtarget, ytarget);
	xspeed += lengthdir_x(400, steer_direction) * Time.deltaTime;
	yspeed += lengthdir_y(400, steer_direction) * Time.deltaTime;
}
// Otherwise, randomly wander
else
{
	var travelDirection = point_direction(0, 0, xspeed, yspeed);
	random_steering += random_range(-720, +720) * Time.deltaTime;
	//random_steering += random_range(-40, +40) * Time.deltaTime;
	//random_steering += sin(current_time/110 + id) * 40.0 * Time.deltaTime;
	//random_steering += cos(current_time/140 + id) * 40.0 * Time.deltaTime;
	random_steering = clamp(random_steering, -90, +90);
	random_steering += random_range(-40, +40);
	xspeed += lengthdir_x(100, travelDirection + random_steering) * Time.deltaTime;
	yspeed += lengthdir_y(100, travelDirection + random_steering) * Time.deltaTime;
}

// fix the speed
var tspeed = sqrt(sqr(xspeed) + sqr(yspeed));
xspeed *= 30 / tspeed;
yspeed *= 30 / tspeed;

// move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// set angle
image_angle = point_direction(0, 0, xspeed, yspeed);

// update lights
m_lightEmissive.x = x;
m_lightEmissive.y = y;
m_lightSmall.x = x;
m_lightSmall.y = y;
m_lightSmall2.x = x;
m_lightSmall2.y = y - z_height;