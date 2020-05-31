/// @description Specific scripting triggers

if (m_state == CtsDeath.S1DeadOverlay)
{
	// 3 seconds for the YOU DIED animation
	m_timer += Time.deltaTime / 3.0;
	// At the end of the 3 seconds, go to the fade out
	if (m_timer >= 1.0)
	{
		m_state = CtsDeath.S2FadeOut;
	}
}
else if (m_state == CtsDeath.S2FadeOut)
{
	if (!iexists(o_fxFadeOutBanded))
	{
		var fadeout = inew(o_fxFadeOutBanded);
			fadeout.image_blend = c_black;
			depth = fadeout.depth - 1;
	}
	
	if (o_fxFadeOutBanded.image_alpha > 1.0)
	{
		m_state = CtsDeath.S3Blackness;
	}
}
else if (m_state == CtsDeath.S3Blackness)
{
	gameDeathSoftReset();
	o_PlayerTest.canMove = false;
	m_state = CtsDeath.S4ViggoTravel;
}
else if (m_state == CtsDeath.S4ViggoTravel)
{
	// Nothing yet!
	m_state = CtsDeath.S5FadeIn;
	
	idelete(o_fxFadeOutBanded);
	
	if (!iexists(o_fxFadeInBanded))
	{
		var fadein = inew(o_fxFadeInBanded);	
			fadein.image_blend = c_black;
			depth = fadein.depth - 1;
	}
}
else if (m_state == CtsDeath.S5FadeIn)
{
	if (!iexists(o_fxFadeInBanded) || o_fxFadeInBanded.image_alpha <= 0.0)
	{
		o_PlayerTest.canMove = true;
		idelete(o_fxFadeInBanded);
		idelete(this);
		
		m_state = CtsDeath.S6Cleanup;
	}
}
else if (m_state == CtsDeath.S6Cleanup)
{
	// Nothing
}