/// @description Set up the cts

event_inherited();

persistent = true;

enum CtsCamp
{
	S1BeginSleep,
	S2FadeOut,
	S3Blackness,
	S4SleepTravel,
	S5FadeIn,
	S6Cleanup,
}

m_waitTime = 3.0;
m_state = CtsCamp.S1BeginSleep;
m_timer = 0;
m_hudWasInCutscene = iexists(o_PlayerHud) ? o_PlayerHud.m_inCutscene : false;

m_startTime = 0.0;

m_runtime = 6.0; // time this runs

// Rendering info
depth = -9101;
m_vfxWorldFlashRequested = false;
m_vfxWorldFlash = 0.0;
m_vfxUIGlitch = 0.0;