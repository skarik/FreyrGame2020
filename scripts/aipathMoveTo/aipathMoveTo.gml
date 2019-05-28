var target_x = argument0;
var target_y = argument1;

// Get the best target to the next point
var next_x = target_x;
var next_y = target_y;

var dx = next_x - x;
var dy = next_y - y;
var ddist = point_distance(0, 0, dx, dy);

// Update the control structs
if (ddist > 10)
{	// Move to the target
	_controlStructUpdate(xAxis, dx / max(kMoveSpeed * 0.9, ddist - 10));
	_controlStructUpdate(yAxis, dy / max(kMoveSpeed * 0.9, ddist - 10));
}
else
{	// Close enough, we can stop
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
}