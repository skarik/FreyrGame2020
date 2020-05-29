if (global._transition_source != null)
{
	// Select matching sized transition
	if (global._transition_dw != abs(32 * image_xscale)
		|| global._transition_dh != abs(32 * image_yscale))
	{
		exit;
	}
	
    // Find matching room
    if (target == global._transition_source) // todo: choose only one
    {
        var pos_x = x;
        var pos_y = y;
        with (getPlayer())
        {   
            // Skip invalid players
            if (m_isPlayer == false) continue;
            
            if (pos_x <= 0) {
                x = pos_x + 2;
            }
            else if (pos_x >= global._transition_rm_width) {
                x = pos_x - 2;
            }
            else {
                x = pos_x;
            }
			if (pos_y <= 0) {
                y = pos_y + 2;
            }
            else if (pos_y >= global._transition_rm_height) {
                y = pos_y - 2;
            }
            else {
                y = pos_y;
            }
			x += global._transition_dx;
            y += global._transition_dy;
            
            persistent = false;
			camera.persistent = false;
            inventory.persistent = false;
			stats.persistent = false;
			
			// update the Z now
			z = collision3_get_highest_meeting(x, y, z);
			z_height = 0;
        }
        with (o_PlayerHud)
        {
            persistent = false;
        }
		with (ob_character)
		{
			var pl = getPlayer();
			
			if (m_isFollower && m_isFollowing)
			{
				persistent = false;
				inventory.persistent = false;
				stats.persistent = false;
				
				if (iexists(pl))
				{
					x = pl.x;
					y = pl.y;
					z = pl.z;
					
					var hardness = inew(o_scrSolidifyFollower);
						hardness.target = id;
						hardness.original_state = isPassthru;
					isPassthru = true;
				}
			}
		}
        
		// Message we switched rooms
		debugOut("transition from " + room_get_name(global._transition_source) + " to " + room_get_name(room));
		
		// Null out the source
        global._transition_source = null;
    }
}

