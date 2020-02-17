/// @function aiRobocrabMoveTo(x, y)
/// @param {Real} x
/// @param {Real} y
/// @return {Boolean} true if arrived

var tx = argument0;
var ty = argument1;
var target_direction;
var target_distance;

// Distance is reused, so calculated now
target_distance = point_distance(x, y, tx, ty);

// have we gotten to the wander point?
if (target_distance < 6.0)
{
	// stop moving
	xAxis.value = 0;
	yAxis.value = 0;
		
	// report arrived
	return true;
}
// move to the wander point
else
{
	target_direction = point_direction(x, y, tx, ty);
		
	// turn towards the direction of the target. No instant snap-to like organics
	facingDirection = turn_towards_direction(facingDirection, target_direction, 180.0 * Time.deltaTime);
		
	// set steering strength based on facing towards target & distance to target.
	var controlSpeed = lerp(1.0,
							0.0,
							saturate(abs(angle_difference(facingDirection, target_direction)) - target_distance / kMoveSpeed * 2.0)
							* saturate(1.0 - target_distance / kMoveSpeed)
							);
		
	xAxis.value = lengthdir_x(controlSpeed, 180 + facingDirection);
	yAxis.value = lengthdir_y(controlSpeed, 180 + facingDirection);
		
	aimingDirection = facingDirection;
	
	// report not yet there
	return false;
}