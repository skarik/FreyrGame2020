///@function worldSetTimeRunning(run)
///@param run {Bool}
function worldSetTimeRunning(argument0) {
	var run = argument0;

	with (o_dayNightCycle)
	{
		m_timeRunning = run;
	}


}
