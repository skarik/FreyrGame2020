/// @description Set up the cts

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

m_startTime = 0.0;

depth = -9101;

persistent = true;