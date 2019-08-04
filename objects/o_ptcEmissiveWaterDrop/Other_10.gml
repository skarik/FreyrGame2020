/// @description draw glow

var dir = point_direction(xprevious, yprevious - z_heightprevious, x, y - z_height);
var dist = sqrt(sqr(xspeed) + sqr(yspeed + zspeed)) * 0.1;

draw_set_color(emissive_blend);
draw_line(x + xoffset,
		  y + yoffset - z_height,
		  x + xoffset - lengthdir_x(dist, dir),
		  y + yoffset - z_height - lengthdir_y(dist, dir));