/// @description Draw glowy bits

var xd = 120;
var yd = 70;

draw_set_color(merge_color(c_crystalblue, c_black, 0.85));
draw_pie(x + xoffset - xd, y + yoffset - yd, x + xoffset + xd, y + yoffset + yd,
		 x + xoffset + lengthdir_x(xd, aimingDirection - 20),
		 y + yoffset + lengthdir_y(yd, aimingDirection - 20),
		 x + xoffset + lengthdir_x(xd, aimingDirection + 20),
		 y + yoffset + lengthdir_y(yd, aimingDirection + 20),
		 false);
		 
draw_set_color(merge_color(c_white, c_black, 0.95));
for (var i = 1; i < 4; ++i)
{
	draw_pie(x + xoffset - xd, y + yoffset - yd, x + xoffset + xd, y + yoffset + yd,
			 x + xoffset + lengthdir_x(xd, aimingDirection - 20 + 90 * i),
			 y + yoffset + lengthdir_y(yd, aimingDirection - 20 + 90 * i),
			 x + xoffset + lengthdir_x(xd, aimingDirection + 20 + 90 * i),
			 y + yoffset + lengthdir_y(yd, aimingDirection + 20 + 90 * i),
			 false);
}