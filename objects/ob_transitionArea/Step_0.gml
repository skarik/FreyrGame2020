var pl = getPlayer();
if (iexists(pl) && place_meeting(x,y,pl))
{
	if (m_isEdgeTransition)
	{
	    // Check for player outside of room
	    if (pl.x > room_width || pl.x < 0 || pl.y > room_height || pl.y < 0)
	    {
	        global._transition_source = room;
			global._transition_dx = pl.x - x;
	        global._transition_dy = pl.y - y;
			global._transition_rm_width = room_width;
			global._transition_rm_height = room_height;
	        global._transition_dw = abs(32 * image_xscale);
			global._transition_dh = abs(32 * image_yscale);
			global._transition_is_edge = true;
			global._transition_ddir = 0;
			if (bbox_left < 0)
			{
				global._transition_ddir = 180;
			}
			else if (bbox_right > room_width)
			{
				global._transition_ddir = 0;
			}
			else if (bbox_top < 0)
			{
				global._transition_ddir = 90;
			}
			else if (bbox_bottom > room_height)
			{
				global._transition_ddir = 270;
			}
			
	        // Then we go to the next room:
	        transition_to(target);
	    }
	}
	else
	{
		// Check for player colliding when not an edge transition
		global._transition_source = room;
		global._transition_dx = (image_xscale > image_yscale) ? (pl.x - x) : 0;
	    global._transition_dy = (image_yscale > image_xscale) ? (pl.y - y) : 0;
		global._transition_rm_width = room_width;
		global._transition_rm_height = room_height;
	    global._transition_dw = abs(32 * image_xscale);
		global._transition_dh = abs(32 * image_yscale);
		global._transition_is_edge = false;
		global._transition_ddir = 0;
		
	    // Then we go to the next room:
	    transition_to(target);
	}
}

