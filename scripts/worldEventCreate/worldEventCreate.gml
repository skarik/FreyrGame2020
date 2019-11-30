#macro kWorldEvent_NoEvent 0
#macro kWorldEvent_Riftpulse 1
#macro kWorldEvent_MakePlayerShirtless 2
#macro kWorldEvent_MakePlayerShirtmore 3

var event = argument0;

debugOut("worldEventCreate(" + string(event) + ") called");

switch (event)
{
case kWorldEvent_Riftpulse:
	break;
	
case kWorldEvent_MakePlayerShirtless:
	{
		var pl = getPlayer();
		if (exists(pl)) {
			pl.pstats.m_shirtless = true;	
		}
	}
	break;
	
case kWorldEvent_MakePlayerShirtmore:
	{
		var pl = getPlayer();
		if (exists(pl)) {
			pl.pstats.m_shirtless = false;	
		}
	}
	break;
}