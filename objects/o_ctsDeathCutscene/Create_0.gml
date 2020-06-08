/// @description Do the death cutscene!

enum CtsDeath
{
	S1DeadOverlay,
	S2FadeOut,
	S3Blackness,
	S4ViggoTravel,
	S5FadeIn,
	S6Cleanup,
}

m_state = CtsDeath.S1DeadOverlay;
m_timer = 0;
m_startTime = 0.0;

depth = -9101;

persistent = true;

m_blockBoxEffect = null;