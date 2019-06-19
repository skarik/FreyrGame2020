/// @description Update params and sprite

if (m_owner != null)
{
	m_name = m_owner.m_name;
	sprite_index = m_owner.mask_index;
	x = m_owner.x;
	y = m_owner.y;
}

if (m_interacting)
{
	// Not in cutscene file mode:
	if (!m_interactingCutscene)
	{
		if (cutsceneIsChoiceReady())
		{
			m_interacting = false;
		}
	}
	
	// In cutscene file mode:
	if (m_interactingCutscene)
	{
		if (!cutsceneUpdate())
		{
			/*if (cutsceneIsChoiceReady())
			{
			
			}*/
			var cts_type = cutsceneGetCurrentType();
			if (object_get_parent(m_user.object_index) == ob_characterFollower
				&& cts_type == SEQTYPE_CHOICES)
			{
				if (exists(o_CtsChoiceBox))
				{
					draw_set_font(global.font_arvo9); // Set font for the width prediction
		
			        var gabber = instance_find(o_CtsChoiceBox, 0);
						gabber.display_width = 0.0;
			            for (var i = 0; i < gabber.input_choice_count; ++i)
			            {
							if (gabber.input_choice[i] == "[FOLLOW]")
							{
								gabber.input_choice[i] = m_owner.m_aiFollowing ? "(Stay here)" : "(Follow me)";
								m_followChoice = i;
							}
							gabber.display_width = max(gabber.display_width, string_width(gabber.input_choice[i]));
			            }
						gabber.display_width = round(gabber.display_width + 10);
				}
				// Do special jumps for the cutscene
				if (cutsceneIsChoiceReady())
				{
					if (cutsceneGetChoice() == m_followChoice)
					{	// Jump to the correct behavior for the AI
						cutsceneJumpToLabel(m_owner.m_aiFollowing ? "SelectFollowStop" : "SelectFollowStart");
					}
				}
			}
			else if (cts_type == SEQTYPE_WAIT)
			{
				var wait_id = cutsceneGetWaitId();
				if (wait_id == "crafting")
				{
					if (!exists(o_CtsChoiceBox))
					{
						cutsceneWaitEnd();
					}
				}
			}
		}
	
		if (cutsceneIsDone())
		{
			cutsceneFree();
			m_interacting = false;
		}
	}
}