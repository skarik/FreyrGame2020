// Check collision in the X direction
if (place_meeting(x + xspeed * Time.deltaTime, y, ob_collider))
{
	// Move contact
	move_contact_with(sign(xspeed), 0, ob_collider);
	// Stop motion
	xspeed = 0;
}
if (place_meeting(x + xspeed * Time.deltaTime, y, ob_character))
{
	// Move contact
	move_contact_with(sign(xspeed), 0, ob_character);
	// Stop motion
	xspeed = 0;
}

// Check collision in the Y direction
if (place_meeting(x, y + yspeed * Time.deltaTime, ob_collider))
{
	// Move contact
	move_contact_with(0, sign(yspeed), ob_collider);
	// Stop motion
	yspeed = 0;
}
if (place_meeting(x, y + yspeed * Time.deltaTime, ob_character))
{
	// Move contact
	move_contact_with(0, sign(yspeed), ob_character);
	// Stop motion
	yspeed = 0;
}