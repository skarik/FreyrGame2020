if (global._transition_source != null)
{
	// check for solo transition
	var t_isOnlyTransition = true;
	with (object_index)
	{
		if (target == global._transition_source
			&& global._transition_dw == abs(32 * image_xscale)
			&& global._transition_dh == abs(32 * image_yscale))
		{
			t_isOnlyTransition = false;
			break;
		}
	}
	if (t_isOnlyTransition)
	{
		if (instance_find(object_index, 0) != id)
		{
			t_isOnlyTransition = false;
		}
	}
	
	// Select matching sized transition
	if (!t_isOnlyTransition
		&& (global._transition_dw != abs(32 * image_xscale)
			|| global._transition_dh != abs(32 * image_yscale)))
	{
		exit;
	}
	
    // Find matching room
    if (target == global._transition_source || t_isOnlyTransition)
    {
        var pos_x = x;
        var pos_y = y;
        with (getPlayer())
        {   
            // Skip invalid players
            if (m_isPlayer == false) continue;
            
			persistent = false;
			camera.persistent = false;
            inventory.persistent = false;
			stats.persistent = false;
			
			if (iexists(global._transition_target_override))
			{
				// update position
				x = global._transition_target_override.x;
				y = global._transition_target_override.y;
				
				// update the Z now
				z = collision3_get_highest_meeting(x, y, z);
				z_height = global._transition_target_override.z - z;
			}
			else
			{
				// Fix position
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
			
				// If teleporting to a non-edge transition, make sure the player is outside of the position
				if (!other.m_isEdgeTransition)
				{
					if (global._transition_ddir == 0)
					{
						x += 2 + other.bbox_right - bbox_left;
					}
					else if (global._transition_ddir == 180)
					{
						x += -2 + other.bbox_left - bbox_right;
					}
					else if (global._transition_ddir == 270)
					{
						y += 2 + other.bbox_bottom - bbox_top;
					}
					else if (global._transition_ddir == 90)
					{
						y += -2 + other.bbox_top - bbox_bottom;
					}
				}
				
				// update the Z now
				z = collision3_get_highest_meeting(x, y, z);
				z_height = 0;
			}
			
			// update followers
			var pl_callee = id;
			for (var i = 0; i < 3; ++i)
			{
				with (pstats.m_party[i])
				{
					persistent = false;
					inventory.persistent = false;
					stats.persistent = false;
					
					x = pl_callee.x;
					y = pl_callee.y;
					z = pl_callee.z;
					
					var hardness = inew(o_scrSolidifyFollower);
						hardness.target = id;
						hardness.original_state = isPassthru;
					isPassthru = true;
				}
			}
        }
        with (o_PlayerHud)
        {
            persistent = false;
        }
        
		// Message we switched rooms
		debugOut("transition from " + room_get_name(global._transition_source) + " to " + room_get_name(room));
		
		// Null out the source
        global._transition_source = null;
    }
}

