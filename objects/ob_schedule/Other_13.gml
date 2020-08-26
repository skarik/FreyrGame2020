/// @description OnSchedule

if (m_scheduleActive)
{
	debugOut("Schedule doing FirstFrame setup.");
	bFirstFrameSetup = true;
}
m_scheduleActive = true;