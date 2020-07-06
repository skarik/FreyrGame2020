
// camp until 6 AM or minimum 3 hours or maximum 12 hours

//o_dayNightCycle.m_timeOfDay

var sleep_time = 6.0 - o_dayNightCycle.m_timeOfDay;
if (sleep_time < 0.0)
{
	sleep_time += 24.0;
}

/*if (sleep_time > 12.0)
{
	sleep_time = 12.0;
}
else*/

sleep_time = clamp(sleep_time, 3.0, 12.0);

gameCampWait(sleep_time);

with (getPlayer())
{
	pstats.m_times_rested += 1;
}