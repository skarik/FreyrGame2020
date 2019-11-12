/// @description Insert description here
// You can write your code in this editor

x += xspeed * Time.deltaTime;
y += yspeed * Time.deltaTime;

image_xscale += 0.2 * Time.deltaTime;
image_yscale += 0.2 * Time.deltaTime * 0.75;

image_alpha -= Time.deltaTime * 1.5;
if (image_alpha <= 0.0)
{
	delete(this);
}