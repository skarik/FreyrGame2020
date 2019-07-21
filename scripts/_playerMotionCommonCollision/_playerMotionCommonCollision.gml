// Check collision in the X direction
//if (place_meeting(x + xspeed * Time.deltaTime, y, ob_collider))
if (collision3_meeting(x + xspeed * Time.deltaTime, y, z + z_height, !onGround))
{
	// Move contact
	//move_contact_with(sign(xspeed), 0, ob_collider);
	collision3_move_contact_meeting(sign(xspeed), 0, !onGround);
	// Stop motion
	xspeed = 0;
}
if (!isDashing) {
if (place_meeting(x + xspeed * Time.deltaTime, y, ob_character))
{
	// Move contact
	move_contact_with(sign(xspeed), 0, ob_character);
	// Stop motion
	xspeed = 0;
}}

// Check collision in the Y direction
//if (place_meeting(x, y + yspeed * Time.deltaTime, ob_collider))
if (collision3_meeting(x, y + yspeed * Time.deltaTime, z + z_height, !onGround))
{
	// Move contact
	//move_contact_with(0, sign(yspeed), ob_collider);
	collision3_move_contact_meeting(0, sign(yspeed), !onGround);
	// Stop motion
	yspeed = 0;
}
if (!isDashing) {
if (place_meeting(x, y + yspeed * Time.deltaTime, ob_character))
{
	// Move contact
	move_contact_with(0, sign(yspeed), ob_character);
	// Stop motion
	yspeed = 0;
}}

// Check for unstuck motion
if (moCanMoveUnstuck)
{
	if (xspeed == 0 && yspeed == 0 && zspeed == 0)
	{
		if (collision3_meeting(x, y, z + z_height, false))
		{
			// We need to move-unstuck.
			_characterMoveUnstuck3();
		}
	}
}