/// @description Bring up choice menu

if (m_owner != null && exists(m_user) && m_user.id == o_PlayerTest.id)
{
	if (!exists(ob_CtsTalker))
	{
		/*Cts_MakeGabber(m_user, "Self", "It's a $b" + m_name + "$$.");*/
		
		draw_set_font(global.font_arvo9); // Set font for the width prediction
		
		var count = m_owner.m_interactChoices;
		var target = m_user;
		var target_inst = instance_find(target, 0);
        var gabber = new(o_CtsChoiceBox);
            gabber.input_choice_count = count;
			gabber.display_width = 0.0;
            for (var i = 0; i < count; ++i)
            {
                gabber.input_choice[i] = m_owner.m_interaction[i];
				gabber.display_width = max(gabber.display_width, string_width(m_owner.m_interaction[i]));
            }
			gabber.input_actor = exists(target_inst) ? target_inst : null;
			gabber.display_width = round(gabber.display_width + 10);

		// Stop moving player, until they are done talking
		with (m_user) controlZero(true);
		with (m_user) canMove = false;
		new(o_CtsReenablePlayerOnCtsEnd);
		
		// Set we are talking so we can check the ending of the choicebox
		m_interacting = true;
	}
}