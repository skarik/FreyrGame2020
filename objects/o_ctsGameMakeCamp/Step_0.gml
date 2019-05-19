/// @description perform states

if (m_state == CtsCamp.S1BeginSleep)
{
	with (o_PlayerTest) controlZero(true);
	with (o_PlayerTest) canMove = false;
	
	m_state = CtsCamp.S2FadeOut;
}
else if (m_state == CtsCamp.S2FadeOut)
{
	/*if (!exists(o_fxFadeOutSolid))
	{
		var fadeout = new(o_fxFadeOutSolid);
			fadeout.image_blend = c_black;
			depth = fadeout.depth - 1;
	}
	
	if (o_fxFadeOutSolid.image_alpha > 1.0)
	{*/
		m_state = CtsCamp.S3Blackness;
	//}
}
else if (m_state == CtsCamp.S3Blackness)
{
	//gameDeathSoftReset();
	// Change time of day now
	m_startTime = o_dayNightCycle.m_timeOfDay;
	m_endTime = o_dayNightCycle.m_timeOfDay + m_waitTime;
	m_startDay = o_dayNightCycle.m_day;
	//o_dayNightCycle.m_timeOfDay += m_waitTime;
	//o_PlayerTest.canMove = false;
	m_state = CtsCamp.S4SleepTravel;
	
	m_timer = 0.0;
}
else if (m_state == CtsCamp.S4SleepTravel)
{
	// Nothing yet!
	/*m_state = CtsCamp.S5FadeIn;
	
	delete(o_fxFadeOutSolid);
	
	if (!exists(o_fxFadeInBanded))
	{
		var fadein = new(o_fxFadeInBanded);	
			fadein.image_blend = c_black;
			depth = fadein.depth - 1;
	}*/
	
	m_timer += Time.deltaTime * 2.0;
	
	o_dayNightCycle.m_timeOfDay = lerp(m_startTime, m_endTime, saturate(m_timer)) % 24.00;
	o_dayNightCycle.m_day = m_startDay;
	
	if (m_timer >= 1.0)
	{
		o_dayNightCycle.m_timeOfDay = m_endTime;
		o_dayNightCycle.m_day = m_startDay;
		m_state = CtsCamp.S5FadeIn;
	}
}
else if (m_state == CtsCamp.S5FadeIn)
{
	/*if (!exists(o_fxFadeInBanded) || o_fxFadeInBanded.image_alpha <= 0.0)
	{*/
		with (o_PlayerTest) canMove = true;
		
		//delete(o_fxFadeInBanded);
		delete(this);
		
		m_state = CtsCamp.S6Cleanup;
	//}
}
else if (m_state == CtsCamp.S6Cleanup)
{
	// Nothing
}