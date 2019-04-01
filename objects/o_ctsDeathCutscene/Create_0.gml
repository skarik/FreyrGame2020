/// @description Do the death cutscene!

enum Cts
{
	S1DeadOverlay,
	S2FadeOut,
	S3Blackness,
	S4ViggoTravel,
	S5FadeIn,
	S6Cleanup,
}

m_state = Cts.S1DeadOverlay;
m_timer = 0;

depth = -9101;

persistent = true;