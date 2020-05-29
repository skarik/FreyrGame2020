/// @description Bring up choice menu

if (m_owner != null && iexists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!iexists(ob_CtsTalker) && !m_interacting)
	{
		/*ctsMakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");*/
		
		/*draw_set_font(global.font_arvo9); // Set font for the width prediction
		
		var count = m_owner.m_interactChoices;
		var target = m_user;
		var target_inst = instance_find(target, 0);
        var gabber = inew(o_CtsChoiceBox);
            gabber.input_choice_count = count;
			gabber.display_width = 0.0;
            for (var i = 0; i < count; ++i)
            {
                gabber.input_choice[i] = m_owner.m_interaction[i];
				gabber.display_width = max(gabber.display_width, string_width(m_owner.m_interaction[i]));
            }
			gabber.input_actor = iexists(target_inst) ? target_inst : null;
			gabber.display_width = round(gabber.display_width + 10);

		// Stop moving player, until they are done talking
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		inew(o_CtsReenablePlayerOnCtsEnd);*/
		
		if (m_owner.m_interactionFile != null && m_owner.m_interactionFile != "")
		{
			m_interactingCutscene = true;
			
			// Load up the cutscene
			cutsceneLoad(m_owner.m_interactionFile);
			
			// Set we are talking so we can check the ending of the choicebox
			m_interacting = true;
		}
		else if (m_owner.m_interactChoices > 0)
		{
			m_interactingCutscene = false;
			
			draw_set_font(global.font_arvo9); // Set font for the width prediction
		
			var count = m_owner.m_interactChoices;
			var target = m_user;
			var target_inst = instance_find(target, 0);
	        var gabber = inew(o_CtsChoiceBox);
	            gabber.input_choice_count = count;
				gabber.display_width = 0.0;
	            for (var i = 0; i < count; ++i)
	            {
	                gabber.input_choice[i] = m_owner.m_interaction[i];
					gabber.display_width = max(gabber.display_width, string_width(m_owner.m_interaction[i]));
	            }
				gabber.input_actor = iexists(target_inst) ? target_inst : null;
				gabber.display_width = round(gabber.display_width * 1.1 + 10);
				
			// Set we are talking so we can check the ending of the choicebox
			m_interacting = true;
		}
		
		if (m_interacting)
		{
			// Stop moving player, until they are done talking
			with (m_user) controlZero(true);
			with (m_user) canMove = false;
			inew(o_CtsReenablePlayerOnCtsEnd);
		}
	}
}