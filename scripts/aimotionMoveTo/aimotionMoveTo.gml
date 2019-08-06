// @function aimotionMoveTo(x, y, speed_percent)
// @param x	xpos to look at
// @param y	ypos to look at
// @param speed_percent	at which we change angle

var tx = argument0;
var ty = argument1;
var tspeed = argument2;

var dx = tx - x;
var dy = ty - y;

var ddist = sqr(dx) + sqr(dy);
var ddist_sqrt = sqrt(ddist);

var finalv_x = dx / ddist_sqrt * tspeed;
var finalv_y = dy / ddist_sqrt * tspeed;

_controlStructUpdate(xAxis, finalv_x);
_controlStructUpdate(yAxis, finalv_y);

// Check we're at the target position
var target_distance = max(2.0, kMoveSpeed * Time.deltaTime);
if (ddist_sqrt <= target_distance)
{
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
}