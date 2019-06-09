/// @description draw the wire

draw_set_color(c_black);

var x1 = x;
var y1 = y;
var x2 = m_wireTarget.x;
var y2 = m_wireTarget.y;
// set up the position
var dir = point_direction(x1, y1, x2, y2);
var dist = point_distance(x1, y1, x2, y2);
// draw a segment every 16 pixels
var divs = ceil(dist / 16) + 1;
// pull the line back
x1 -= lengthdir_x(1.0, dir);
y1 -= lengthdir_y(1.0, dir);


var dx1, dy1, dx2, dy2;
dx1 = x1;
dy1 = y1;

for (var i = 0; i <= divs; ++i)
{
	var blend0 = i / divs;
	var drop = 0.5 - abs(0.5 - blend0);
	drop *= 2.0; // make it a linear 0.0 to 1.0
	
	// pull previous point
	dx2 = dx1;
	dy2 = dy1;
	// get next point
	var dx1 = lerp(x1, x2, blend0);
	var dy1 = lerp(y1, y2, blend0);
	
	// drop the wire
	dy1 += sqrt(drop) * sqrt(dist) * 0.5;
	// make it sway!
	dx1 += drop * sin(i * 0.04 + current_time * 0.001 + id) * sqrt(dist) * 0.3;
	
	// finally, draw the segment
	draw_line(dx1, dy1, dx2, dy2);
}