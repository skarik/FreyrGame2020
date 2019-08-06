/// @description The classic moveStepUnstuck from Withstand, modified for Freyr.

//if ( place_meeting( x,y-1, ob_collider ) )
if (collision3_meeting(x, y, z + z_height, false))
{
    var dist, angle, tx, ty, meeting;
    meeting = true;
    
    for ( dist = 1; dist < abs(sprite_width) * 1.5; dist += 1 )
    {
        //debugOut( "unstuck dist: " + string( dist ) );
        if ( meeting )
        {
            for ( angle = 0; angle < 360; angle += 45 )
            {
                if ( meeting )
                {
                    tx = x + lengthdir_x(dist, angle);
                    ty = y + lengthdir_y(dist, angle);
					if (!collision3_meeting(tx, ty, z + z_height, false))
                    {
                        debugOut("Warning 003: Player stuck inside platform. Automatically finding new position. This can be saftely ignored.");
                        meeting = false;
                        x += lengthdir_x(dist + 1, angle);
                        y += lengthdir_y(dist + 1, angle);
                    }
                }
            }
        }
    }
    
    if ( meeting )
	{
		debugOut("Fatal Warning 003: Player stuck inside platform. Game is officially broken. Please check that your masks were not broken by the GM7 to GM8 conversion!");
    }
}