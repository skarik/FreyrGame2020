/// @description The classic moveStepUnstuck from Withstand, modified for Freyr.
function _characterMoveUnstuck3() {

	var startAngle = round(facingDirection / 45) * 45 + 180;
	var endAngle = startAngle + 360;

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
	            for ( angle = startAngle; angle < endAngle; angle += 45 )
	            {
	                if ( meeting )
	                {
	                    tx = x + lengthdir_x(dist, angle);
	                    ty = y + lengthdir_y(dist, angle);
						if (!collision3_meeting(tx, ty, z + z_height, false))
	                    {
	                        debugOut("Warning 003: Player stuck inside platform. Automatically finding new position. This can be safely ignored.");
	                        meeting = false;
							x = tx;
							y = ty;
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


}
