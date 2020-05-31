/// @description Specific scripting triggers

var pl = getPlayer();

if (m_state == CtsDeath.S1DeadOverlay)
{
	// 3 seconds for the YOU DIED animation
	m_timer += Time.deltaTime / 3.0;
	// At the end of the 3 seconds, go to the fade out
	if (m_timer >= 1.0)
	{
		m_state = CtsDeath.S2FadeOut;
	}
	
	// Disable player motion
	pl.canMove = false;
}
else if (m_state == CtsDeath.S2FadeOut)
{
	if (!iexists(o_fxFadeOutBanded))
	{
		var fadeout = inew(o_fxFadeOutBanded);
			fadeout.image_blend = c_black;
			fadeout.depth = kUiDepthHudBase - 2;
			depth = fadeout.depth - 1;
	}
	
	if (o_fxFadeOutBanded.image_alpha > 1.0)
	{
		m_state = CtsDeath.S3Blackness;
	}
}
else if (m_state == CtsDeath.S3Blackness)
{
	if (!iexists(o_CtsChoiceBox))
	{
		m_blockBoxEffect = inew(o_CtsBlackBoxes);
		m_blockBoxEffect.persistent = true;
		
		// Ask for if we want to restart at last checkpoint or at the farm
		var gabber = inew(o_CtsChoiceBox);
			gabber.input_choice_count = 2;
			gabber.input_choice[0] = "Revive at save pillar";
			gabber.input_choice[1] = "Return to the oasis farm";
			gabber.input_actor = id;
			gabber.depth = depth - 1;
			
		x = GameCamera.x;
		y = GameCamera.y + 128;
	}
	else if (cutsceneIsChoiceReady())
	{
		m_state = CtsDeath.S4ViggoTravel;
		
		var choice = cutsceneGetChoice();
		if (choice == 0)
		{
			gameDeathSoftestReset();
			m_state = CtsDeath.S4ViggoTravel;
		}
		else if (choice == 1)
		{
			gameDeathSoftReset();
			m_state = CtsDeath.S4ViggoTravel;
		}
	}
	//gameDeathSoftReset();
	//
}
else if (m_state == CtsDeath.S4ViggoTravel)
{
	// Nothing yet!
	m_state = CtsDeath.S5FadeIn;
	
	idelete(m_blockBoxEffect);
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
		pl.canMove = true;
		idelete(o_fxFadeInBanded);
		idelete(this);
		
		m_state = CtsDeath.S6Cleanup;
	}
}
else if (m_state == CtsDeath.S6Cleanup)
{
	// Nothing
}