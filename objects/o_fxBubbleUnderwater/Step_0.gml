/// @description rise up gamers

x += xspeed_base * sin(current_time / 400 + id) * Time.deltaTime * 2.0;
y -= yspeed_base * Time.deltaTime;

if (y < -10)
{
	delete(this);
}