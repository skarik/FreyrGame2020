var in_waitTime = argument0;

var enemiesNearby = false;

// check for enemies
if (enemiesNearby)
{
	
}
// need to start a waiting cts
else
{
	//o_dayNightCycle.m_timeOfDay += in_waitTime;
	if (!exists(o_ctsGameMakeCamp))
	{
		var campCts = new(o_ctsGameMakeCamp);
			campCts.m_waitTime = in_waitTime;
	}
}