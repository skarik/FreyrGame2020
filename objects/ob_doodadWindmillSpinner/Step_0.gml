/// @description SPEEN 

// Inherit the parent event
event_inherited();

if (visible)
{
	image_angle -= (sin(Time.time + (id mod 1000)) * 10.0 + 30.0) * Time.deltaTime;
}