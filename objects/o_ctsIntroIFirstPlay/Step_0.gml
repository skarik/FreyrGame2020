/// @description ctsupdate
if (!cutsceneUpdate())
{
	if (cutsceneGetWaitId() == "init")
    {
		m_initTimer += min(0.05, Time.deltaTime);
		if (m_initTimer > 0.5)
		{
			// create the explosions in the distance w/ the player
			instance_create_depth(x, y, 50, o_fxExploUnderwater);
			// create the player doodad on top
			m_playerDoodad = instance_create_depth(x, y - 10, 35, _dummy);
			m_playerDoodad.sprite_index = s_charHeroStand;
			m_playerDoodad.image_speed = 0;
			m_playerDoodad.image_index = 0;
			m_playerDoodad.image_angle = 180;
			m_playerDoodad.image_blend = false;
			m_playerDoodad.visible = true;
			
			effectScreenShake(1, 3.0, true);
		
			cutsceneWaitEnd();
		}
	}
	
	if (cutsceneGetWaitId() == "menu")
    {
		// bring up the choice menu
		if (!exists(m_logo))
		{
			m_logo = instance_create_depth(x, y, 0, o_dummyDrawOutlineTemp);
			m_logo.sprite_index = sui_logo1;
			m_logo.image_alpha = 0.0;
			m_logo.visible = true;
			
			instance_create_depth(x, y + 90, 5, o_doodadPressAnything);
		}
		else
		{
			m_logo.image_alpha += Time.deltaTime * 0.5;
			m_logo.image_alpha = saturate(m_logo.image_alpha);
		}
		
		// Check input
		if (controlAnyKey())
		{
			m_fadeLogo = true;
			with (o_doodadPressAnything) fade = true;
			cutsceneWaitEnd();
		}
	}
	
	if (cutsceneGetCurrentType() == SEQTYPE_CHOICES)
	{
		if (cutsceneIsChoiceReady())
		{
			var choice = cutsceneGetChoice();
			if (cutsceneGetChoiceId() == "gender")
			{
				// female/male/neither
				//show_message((choice == 0) ? "female" : ((choice == 1) ? "male" : "neither"));
			}
			else if (cutsceneGetChoiceId() == "hairstyle")
			{
				//short/pigtails/ponytail
				//show_message((choice == 0) ? "short" : ((choice == 1) ? "pigtails" : "ponytail"));
			}
			else if (cutsceneGetChoiceId() == "clothes")
			{
				//ruffled/croptop/skirt
				if (choice == 1) choice = 2;
				else if (choice == 2) choice = 1;
				//show_message((choice == 0) ? "ruffled" : ((choice == 1) ? "skirt" : "crop top"));
			}
		}
	}
	
	if (cutsceneGetWaitId() == "ending")
	{
		if (!exists(o_fxFadeOutSolid))
		{
			var fadeout = new(o_fxFadeOutSolid);
				fadeout.image_blend = c_white;
		}
		else
		{
			if (o_fxFadeOutSolid.image_alpha >= 1.0)
			{
				// TODO: either clear all stats flags or create new flags object for player...
				room_goto(rm_oasis_farm);
			}
		}
	}
}

// Create bubbles
m_bubbleTimer += Time.deltaTime * 5.0;
while (m_bubbleTimer > 1.0)
{
	m_bubbleTimer -= 1.0;
	instance_create_depth(random(room_width), room_height + random(64), 55, o_fxBubbleUnderwater);
}

// Fade logo away
if (m_fadeLogo && exists(m_logo))
{
	m_logo.image_alpha -= Time.deltaTime * 2.0;
	m_logo.image_alpha = saturate(m_logo.image_alpha);
}

// Update game camera position
GameCamera.x = x;
GameCamera.y = y;