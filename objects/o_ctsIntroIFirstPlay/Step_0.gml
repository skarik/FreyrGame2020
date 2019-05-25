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
			m_playerDoodad = instance_create_depth(x, y + 13, 35, _dummy);
			m_playerDoodad.sprite_index = choose(s_heroSinkingB0, s_heroSinkingB1, s_heroSinkingB2);
			m_playerDoodad.image_blend = c_black;
			m_playerDoodad.visible = true;
			
			m_playerDoodadHead = instance_create_depth(x, y + 13, 34, _dummy);
			m_playerDoodadHead.sprite_index = choose(s_heroSinkingH0, s_heroSinkingH1, s_heroSinkingH2);
			m_playerDoodadHead.image_blend = c_black;
			m_playerDoodadHead.visible = true;
			
			// create stats
			var stats = new(o_PlayerStats);
				stats.persistent = true;
			
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
		var choice = cutsceneGetChoice();
		
		// Update the sprite based on the hovered choice
		
		if (cutsceneGetChoiceId() == "gender")
		{
			// female/male/neither
			if (cutsceneIsChoiceReady())
			{
				//show_message((choice == 0) ? "female" : ((choice == 1) ? "male" : "neither"));
				o_PlayerStats.m_gender = choice;
				o_PlayerStats.m_name = (choice == 0) ? "Aurum" : ((choice == 1) ? "Cortez" : "Pyrite")
			}
			
			// There actually would be no visual changes! Just make the player fade in over this choice
			m_playerFadeIn = true;
		}
		else if (cutsceneGetChoiceId() == "hairstyle")
		{
			//short/pigtails/ponytail
			if (cutsceneIsChoiceReady())
			{
				//show_message((choice == 0) ? "short" : ((choice == 1) ? "pigtails" : "ponytail"));
				o_PlayerStats.m_head = choice;
			}
			
			m_playerDoodadHead.sprite_index = (choice == 0) ? s_heroSinkingH0 : ((choice == 1) ? s_heroSinkingH1 : s_heroSinkingH2)
			
		}
		else if (cutsceneGetChoiceId() == "clothes")
		{
			//ruffled/croptop/skirt
			if (choice == 1) choice = 2;
			else if (choice == 2) choice = 1;
			
			if (cutsceneIsChoiceReady())
			{
				//show_message((choice == 0) ? "ruffled" : ((choice == 1) ? "skirt" : "crop top"));
				o_PlayerStats.m_body = choice;
			}
			
			m_playerDoodad.sprite_index = (choice == 0) ? s_heroSinkingB0 : ((choice == 1) ? s_heroSinkingB1 : s_heroSinkingB2)
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

// Update all gabbers
with (o_CtsGabberBox)
{
	// clear out input actor to fix odd behavior
	if (exists(input_actor) && input_actor.object_index == o_PlayerImp)
	{
		input_actor = null;
	}
}

// Update signal sampling
if (cutsceneHasSignal())
{
	var signal = cutsceneGetSignal();
	cutsceneSignalConsume();
		
	debugOut("Consumed the signal \"" + signal + "\"");
		
	// We want to create the 
	if (signal == "create_imp")
	{
		debugOut("Acting on create_imp signal.");
		instance_create_depth(x, 80, 40, o_PlayerImp);
		o_PlayerImp.image_blend = c_black;
		m_ImpFadeIn = true;
	}
	if (signal == "imp_fade")
		m_ImpFadeIn = false;
	if (signal == "imp_show")
		m_ImpFadeIn = true;
}

// Fade in player on demand
if (exists(m_playerDoodad))
{
	if (m_playerFadeIn)
	{
		m_playerFadeLevel += Time.deltaTime;
	}
	else
	{
		m_playerFadeLevel -= Time.deltaTime;
	}
	
	m_playerFadeLevel = saturate(m_playerFadeLevel);
	m_playerDoodad.image_blend = merge_color(c_black, c_white, m_playerFadeLevel);
	m_playerDoodadHead.image_blend = merge_color(c_black, c_white, m_playerFadeLevel);
}

// Fade in imp on demand
if (exists(o_PlayerImp))
{
	if (m_ImpFadeIn)
	{
		m_ImpFadeLevel += Time.deltaTime;
	}
	else
	{
		m_ImpFadeLevel -= Time.deltaTime;
	}
	
	m_ImpFadeLevel = saturate(m_ImpFadeLevel);
	o_PlayerImp.image_blend = merge_color(c_black, c_white, m_ImpFadeLevel);
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