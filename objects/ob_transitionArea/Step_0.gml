var pl = getPlayer();
if (iexists(pl) && place_meeting(x,y,pl))
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
		
        // Then we go to the next room:
        transition_to(target);
    }
}

