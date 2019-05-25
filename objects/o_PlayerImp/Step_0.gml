/// @description Simple AI motion

if (m_aiScript_requestCommand == kAiRequestCommand_Move)
{
	m_aiScript_requestCommand = null;
	
	if (x != m_aiScript_requestPositionX || y != m_aiScript_requestPositionY)
	{
		// Create flash step
		if (color_get_red(image_blend) > 128)
		{
			instance_create_depth(x, y, depth, o_dummyDrawOutlineTempFade);
			o_dummyDrawOutlineTempFade.sprite_index = sprite_index;
			o_dummyDrawOutlineTempFade.image_index = image_index;
			o_dummyDrawOutlineTempFade.image_speed = 0.0;
			o_dummyDrawOutlineTempFade.image_alpha = 0.5;
		}
		
		// Update position
		x = m_aiScript_requestPositionX;
		y = m_aiScript_requestPositionY;
	}
}

if (m_aiScript_requestCommand == kAiRequestCommand_Animation)
{
	if (m_aiScript_requestAnimation == "default")
	{
		sprite_index = s_charLibrarianBig;
	}
	else if (m_aiScript_requestAnimation == "look_up")
	{
		sprite_index = s_charLibrarianBigLookUp;
	}
	else if (m_aiScript_requestAnimation == "shake_head")
	{
		sprite_index = s_charLibrarianBigHeadShake;
	}
}