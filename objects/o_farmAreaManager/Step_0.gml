/// @description for now: moths

if (!timeofdayIsDaytime())
{
	if (iexists(o_cropTurnip))
	{
		if (instance_number(o_chBugLunarMoth) < 6) {
			var bug = inew(o_chBugLunarMoth);
				bug.x = GameCamera.x + choose(1, -1) * GameCamera.width * 0.6; 
				bug.y = GameCamera.y + choose(1, -1) * GameCamera.height * 0.6;
		}
	}
}