function timeofdayGetHour() {
	if (iexists(o_dayNightCycle))
	{
		return o_dayNightCycle.m_timeOfDay;
	}
	return 9.00;


}
