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

_playerMotionCommonCollision();

// Finally move
x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

// override position
var goto_x = lerp(dashStartX, dashTargetX, dashPercentage);
var goto_y = lerp(dashStartY, dashTargetY, dashPercentage);

move_contact_with(goto_x - x, goto_y - y, ob_collider);

if (dashPercentage >= 1.0)
{
	isDashing = false;
	
	// TODO: check collision
	//x = dashTargetX;
	//y = dashTargetY;
	xspeed = 0.0; // Stop at end of dash
	yspeed = 0.0; 
}