moHitWall = false;

// Check collision in the X direction
if (abs(xspeed) > 0)
{
	if (collision3_meeting(x + xspeed * Time.deltaTime, y, z + z_height, !onGround))
	{
		// Move contact
		//move_contact_with(sign(xspeed), 0, ob_collider);
		collision3_move_contact_meeting(sign(xspeed), 0, !onGround);
		// Stop motion
		xspeed = 0;
		// Mark we hit a wall
		moHitWall = true;
	}
}
if (!isDashing)
{
	var char = instance_place(x + xspeed * Time.deltaTime, y, ob_character);
	if (iexists(char) && !char.isEthereal && !char.isPassthru)
	{
		// Move contact
		move_contact_with(sign(xspeed), 0, char);
		// Stop motion
		xspeed = 0;
	}
}

// Check collision in the Y direction
if (abs(yspeed) > 0.0)
{
	if (collision3_meeting(x, y + yspeed * Time.deltaTime, z + z_height, !onGround))
	{
		// Move contact
		//move_contact_with(0, sign(yspeed), ob_collider);
		collision3_move_contact_meeting(0, sign(yspeed), !onGround);
		// Stop motion
		yspeed = 0;
		// Mark we hit a wall
		moHitWall = true;
	}
}
if (!isDashing)
{
	var char = instance_place(x, y + yspeed * Time.deltaTime, ob_character);
	if (iexists(char) && !char.isEthereal && !char.isPassthru)
	{
		// Move contact
		move_contact_with(0, sign(yspeed), char);
		// Stop motion
		yspeed = 0;
	}
}

// Check for unstuck motion
if (moCanMoveUnstuck)
{
	if (xspeed == 0 && yspeed == 0 && zspeed == 0)
	{
		if (moInternal_UnstuckTimer > 1.0)
		{
			if (collision3_meeting(x, y, z + z_height, false))
			{
				// We need to move-unstuck.
				_characterMoveUnstuck3();
			}
			moInternal_UnstuckTimer = min(1.0, moInternal_UnstuckTimer - Time.deltaTime);
		}
		else
		{
			moInternal_UnstuckTimer += Time.deltaTime * 4.0;
		}
	}
}

// Do BETTER unstuck motion (but for characters only)
if (kKickbackAmount > 0.0 && !isPassthru)
{
	if (point_on_camera(x, y))
	{
		// Get collision with other characters
		var colliding_character = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, ob_characterGround, false, true);
		if (iexists(colliding_character) && !colliding_character.isPassthru)
		{
			// See if can move 1 pixel out of the character
			var unstuck_direction = point_direction(colliding_character.x, colliding_character.y, x, y);
			var tx = x + lengthdir_x(1, unstuck_direction);
			var ty = y + lengthdir_y(1, unstuck_direction);
			if (!collision3_meeting(tx, ty, z + z_height, true))
			{
				x = tx;
				y = ty;
			}
		}
	}
}