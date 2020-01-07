/// @description flutter

var xtarget = room_width * 0.5;
var ytarget = room_height * 1.5;

// Placed moth?
//if (xstart > 0 && ystart > 0 && xstart < room_width && ystart < room_height)
//{
	xtarget = xstart;
	ytarget = ystart;
	
	mothMotionTowards(xtarget, ytarget, 40);
//}
// Procedural moth? TODO: Test later on farm.
/*else
{
	if (timeofdayIsDaytime())
	{
		// If have no spot, select a spot to hover nearby the player.
		if (!hoverHasPosition)
		{
			hoverHasPosition = true;
			hoverResetTimer = 0.0;
		
			hoverAreaX = o_PlayerTest.x + random_range(-200, +200);
			hoverAreaY = o_PlayerTest.y + random_range(-200, +200);
		}
		// Otherwise keep track of time we're going to that spot
		else
		{
			hoverResetTimer += Time.deltaTime / 20.0; // Every 20 seconds, find a new spot
			if (hoverResetTimer > 1.0)
				hoverHasPosition = false;
		}
	
		// Go to that hover area
		xtarget = hoverAreaX;
		ytarget = hoverAreaY;
	}
	else
	{
		// At night, reset the spot we selected - and go offscreen.
		hoverHasPosition = false;
		hoverResetTimer = 0.0;
	}
	
	mothMotionTowards(xtarget, ytarget, 20);
}*/

// update lights
m_lightEmissive.x = x;
m_lightEmissive.y = y;
m_lightSmall.x = x;
m_lightSmall.y = y;
m_lightSmall2.x = x;
m_lightSmall2.y = y - z_height;