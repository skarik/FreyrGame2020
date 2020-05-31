/// @description go to nearest turnip

var xtarget = room_width * 0.5;
var ytarget = room_height * 1.5;
if (iexists(o_cropTurnip) && !timeofdayIsDaytime())
{
	var turnip = instance_nearest(x, y, o_cropTurnip);
	xtarget = turnip.x;
	ytarget = turnip.y;
}

mothMotionTowards(xtarget, ytarget, 20);

// update lights
m_lightEmissive.x = x;
m_lightEmissive.y = y;
m_lightSmall.x = x;
m_lightSmall.y = y;
m_lightSmall2.x = x;
m_lightSmall2.y = y - z_height;