/// @description set up water drop

depthInit();

zprevious = 0;
z_heightprevious = 0;

zspeed = 0;
xspeed = 0;
yspeed = 0;

emissive_blend = c_white;

function depthWorldDraw_PtcEmissiveWaterDrop()
{
	var dir = point_direction(xprevious, yprevious - z_heightprevious, x, y - z_height);
	var dist = sqrt(sqr(xspeed) + sqr(yspeed + zspeed)) * 0.1;

	draw_set_color(image_blend);
	draw_line(x, y - z_height, x - lengthdir_x(dist, dir), y - z_height - lengthdir_y(dist, dir));
}
depthSetWorldDrawFunction(depthWorldDraw_PtcEmissiveWaterDrop);