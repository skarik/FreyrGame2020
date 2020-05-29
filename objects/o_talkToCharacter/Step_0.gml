/// @description Update params and sprite

if (m_owner != null && iexists(m_owner))
{
	m_name = m_owner.m_name;
	sprite_index = m_owner.mask_index;
	x = m_owner.x;
	y = m_owner.y;
}

if (m_owner != null && !iexists(m_owner))
{
	idelete(this);
	exit;
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
		if (cutsceneHasSignal())
		{
			var signal_id = cutsceneGetSignal();
			
			if (signal_id == "reveal_name")
			{
				// Set the name
				switch (m_owner.object_index)
				{
				case o_chNathan:	m_owner.m_name = "Nathan"; break;
				case o_chViggo:		m_owner.m_name = "Viggo"; break;
				}
				
				// Consume the signal
				cutsceneSignalConsume();
			}
		}
		
		if (!cutsceneUpdate())
		{
			/*if (cutsceneIsChoiceReady())
			{
			
			}*/
			var cts_type = cutsceneGetCurrentType();
			if (object_get_parent(m_owner.object_index) == ob_characterFollower
				&& cts_type == SEQTYPE_CHOICES)
			{
				if (iexists(o_CtsChoiceBox))
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
					if (!iexists(o_CtsChoiceBox))
					{
						cutsceneWaitEnd();
					}
				}
				else if (wait_id == "fortune")
				{
					if (!iexists(o_CtsChoiceBox))
					{
						if (!iexists(o_ctsUiTarot))
						{
							cutscenePlayerLock();
							inew(o_ctsUiTarot);
						}
						else if (o_ctsUiTarot.m_ending)
						{
							cutsceneWaitEnd();
							cutscenePlayerUnlock();
						}
					}
				}
			}
		}
	
		if (cutsceneIsDone())
		{
			cutsceneFree();
			m_interacting = false;
		}
		
	} // End cutscene mode
	
}