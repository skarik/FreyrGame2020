// Update checks
_playerMotionCommonChecks();

// Set up the move speed
//var l_moveSpeed = kMoveSpeed;

dashTimer += Time.deltaTime;

var dashPercentage = clamp(dashTimer / kDashTime, 0.0, 1.0);

var dashDirection = point_direction(dashStartX, dashStartY, dashTargetX, dashTargetY);
var dashSpeed = kDashDistance / kDashTime;

xspeed = lengthdir_x(dashSpeed, dashDirection);
yspeed = lengthdir_y(dashSpeed, dashDirection);

// Do we push the dash into the air?
if (kDashInAir)
{
	var airRunPercent = dashPercentage * 1.3;
	
	// Make sure we're in the air when...we're in the air
	if (airRunPercent < 1.0)
	{
		onGround = false;
	}
	
	// Rise up & fall w/ the height target, but if falling dont override it
	var z_height_target = dashStartZ + dashStartZ_height + 8.0 * sin(min(1.0, airRunPercent) * pi);
	if (airRunPercent < 1.0 || z_height_target < (z + z_height))
	{
		z_height += (z_height_target - (z + z_height));
	}
}

// Update Z
_playerMotionCommonZUpdate();

// Perform collision
_playerMotionCommonCollision();

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// override position
var goto_x = lerp(dashStartX, dashTargetX, dashPercentage);
var goto_y = lerp(dashStartY, dashTargetY, dashPercentage);

if (place_meeting(x, y, ob_collider) || place_meeting(goto_x, goto_y, ob_collider))
{
	//move_contact_with(goto_x - x, goto_y - y, ob_collider);
	collision3_move_contact_meeting(goto_x - x, goto_y - y, true);
}
/*if (place_meeting(x, y, ob_character) || place_meeting(goto_x, goto_y, ob_character))
{
	move_contact_with(goto_x - x, goto_y - y, ob_character);
}*/

if (dashPercentage >= 1.0)
{
	isDashing = false;
	
	// TODO: check collision
	//x = dashTargetX;
	//y = dashTargetY;
	xspeed = 0.0; // Stop at end of dash
	yspeed = 0.0; 
}