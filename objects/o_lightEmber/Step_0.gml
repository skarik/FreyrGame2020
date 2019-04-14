/// @description wiggle, rise, and fade

image_alpha -= Time.deltaTime * 4.0;

x += xspeed_base * sin(current_time / 80 + id) * Time.deltaTime;
y -= yspeed_base * Time.deltaTime;

depthUpdate();

if (image_alpha < 0.0)
{
	delete(this);
}