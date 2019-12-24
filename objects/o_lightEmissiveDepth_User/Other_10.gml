/// @description draw sprite with depth

if (mask)
	shader_set(sh_colormaskAlphatest);
	
draw_set_color(c_white);
var object = id;
with (target)
{
	xoffset = object.xoffset;
	yoffset = object.yoffset;
	event_user(0);
}

if (mask)
	shader_reset();