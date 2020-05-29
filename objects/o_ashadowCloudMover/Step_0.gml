/// @description Move cloud & fade in

image_alpha = min(1.0, image_alpha + Time.deltaTime * 0.1);

var wind = weatherGetWind();
xspeed = motion1d_to(xspeed, wind[0] * 0.1, 2.0 * Time.deltaTime);
yspeed = motion1d_to(yspeed, wind[1] * 0.1, 2.0 * Time.deltaTime);

x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

if (x < -200 || x > room_width + 200
	|| y < -200 || y > room_height + 200)
{
	idelete(this);
	exit;
}