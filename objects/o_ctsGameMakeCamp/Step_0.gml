/// @description perform states

// Update vfx
if (m_vfxWorldFlashRequested)
{
	m_vfxWorldFlash = min(1.0, m_vfxWorldFlash + Time.deltaTime * 7.0);
	if (m_vfxWorldFlash >= 1.0)
	{
		m_vfxWorldFlashRequested = false;
	}
}
else
{
	m_vfxWorldFlash = max(0.0, m_vfxWorldFlash - Time.deltaTime * 5.0);
}

if (m_state == CtsCamp.S2FadeOut
	|| m_state == CtsCamp.S3Blackness
	|| m_state == CtsCamp.S4SleepTravel)
{
	m_vfxUIGlitch = min(1.0, m_vfxUIGlitch + Time.deltaTime * 2.0);
}
else
{
	m_vfxUIGlitch = max(0.0, m_vfxUIGlitch - Time.deltaTime * 3.0);
}

// Update states
if (m_state == CtsCamp.S1BeginSleep)
{
	with (o_PlayerTest) controlZero(true);
	with (o_PlayerTest) canMove = false;
	
	ctsShowBars();
	m_vfxWorldFlashRequested = true;
	
	m_state = CtsCamp.S2FadeOut;
}
else if (m_state == CtsCamp.S2FadeOut)
{
	with (o_PlayerTest) controlZero(true);
	with (o_PlayerTest) canMove = false;
	
	/*if (!iexists(o_fxFadeOutSolid))
	{
		var fadeout = inew(o_fxFadeOutSolid);
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
	with (o_PlayerTest) controlZero(true);
	with (o_PlayerTest) canMove = false;
	
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
	with (o_PlayerTest) controlZero(true);
	with (o_PlayerTest) canMove = false;
	// Nothing yet!
	/*m_state = CtsCamp.S5FadeIn;
	
	idelete(o_fxFadeOutSolid);
	
	if (!iexists(o_fxFadeInBanded))
	{
		var fadein = inew(o_fxFadeInBanded);	
			fadein.image_blend = c_black;
			depth = fadein.depth - 1;
	}*/
	
	m_timer += Time.deltaTime / m_runtime;
	
	o_dayNightCycle.m_timeOfDay = lerp(m_startTime, m_endTime, saturate(m_timer)) % 24.00;
	o_dayNightCycle.m_day = m_startDay;
	
	if (m_timer >= 1.0)
	{
		o_dayNightCycle.m_timeOfDay = m_endTime;
		o_dayNightCycle.m_day = m_startDay;
		o_dayNightCycle.m_hourPassed = true; // Force on-hour updates
		m_state = CtsCamp.S5FadeIn;
	}
	
	// Perform proper time updates:
	with (o_dayNightCycle)
	{
		// Loop the time around
		if (m_timeOfDay >= 24.00)
		{
			m_timeOfDay -= 24.00;
			m_day += 1;
		}
	}
}
else if (m_state == CtsCamp.S5FadeIn)
{
	/*if (!iexists(o_fxFadeInBanded) || o_fxFadeInBanded.image_alpha <= 0.0)
	{*/
		with (o_PlayerTest) canMove = true;
		if (iexists(o_PlayerHud))
		{
			o_PlayerHud.m_inCutscene = m_hudWasInCutscene;
		}
		
		m_vfxWorldFlashRequested = true;
		//idelete(o_fxFadeInBanded);
		//idelete(this);
		
		m_state = CtsCamp.S6Cleanup;
	//}
}
else if (m_state == CtsCamp.S6Cleanup)
{
	// Nothing
	if (m_vfxWorldFlash <= 0.0 && m_vfxUIGlitch <= 0.0)
	{
		idelete(this);
	}
}