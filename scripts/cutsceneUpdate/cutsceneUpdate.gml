/// @description Cutscene_Update
// Returns true if the cutscene is not being paused, false if it needs script input.

global._cutscene_main = this;

if (cutsceneIsDone())
{
    return false;
}

var entry_type = cts_entry_type[cts_entry_current];
var entry = cts_entry[cts_entry_current];

switch (entry_type)
{
case SEQTYPE_NULL:
case SEQTYPE_LABEL:
    cts_entry_current++;
    cts_execute_state = 0;
	
	// Set as a no-frame event
	return _cutsceneUpdateNoFrame();
    break;

case SEQTYPE_WAIT:
    if (cts_execute_state == 0)
    {   // Go to timer state
        cts_execute_state = 1;
        cts_execute_timer = 0;
		
		// Debug output
		debugOut("Doing waiting...");
    }
    else
    {
        if (ds_map_find_value(entry, SEQI_TYPE) == SEQWAIT_TIME)
        {   // Increment timer and check for max time
            cts_execute_timer += Time.dt;
            if (cts_execute_timer > ds_map_find_value(entry, SEQI_TIME))
            {
                cts_entry_current++;
                cts_execute_state = 0;
            }
        }
        else
        {
            // We don't do anything...
        }
    }
    return false;
    
case SEQTYPE_LINES:
    if (cts_execute_state == 0)
    {
        var count = ds_map_find_value(entry, SEQI_COUNT);
        var target = ds_map_find_value(entry, SEQI_TARGET);
        var line = ds_map_find_value(entry, SEQI_LINE);
        var facing = ds_map_find_value(entry, SEQI_FACING);
        var ending = ds_map_find_value(entry, SEQI_ENDACTION);
		var style = ds_map_find_value(entry, SEQI_STYLE);
        
        var target_inst = instance_find(target, (style != kLinesStyle_Portrait) ? count : 0);
		var l_organic = (ending == SEQEND_ORGANIC) || cts_organic;
    
		// FREYR SPECIFIC:
		// Replace the line with the player gender-specific line if possible:
		var pl = getPlayer();
		if (exists(pl))
		{
			var new_line = undefined;
			var gender = pl.pstats.m_gender;
			
			if (gender == kGenderMale)
				new_line = ds_map_find_value(entry, SEQI_LINE + SEQI_LINE_OFFSET_MALE);
			if (gender == kGenderFemale)
				new_line = ds_map_find_value(entry, SEQI_LINE + SEQI_LINE_OFFSET_FEMALE);
			if (gender == kGenderNonbi)
				new_line = ds_map_find_value(entry, SEQI_LINE + SEQI_LINE_OFFSET_NONBI);
				
			if (!is_undefined(new_line))
				line = new_line;
		}
	
        // Make a talker with all the input info
		if (style == kLinesStyle_Default)
		{
	        var gabber = ctsMakeGabber(target_inst, "", line);
	            gabber.input_priority = !l_organic;
	            gabber.input_disable = l_organic;
	            gabber.input_autoclose = (ending == SEQEND_AUTO);
		}
		else if (style == kLinesStyle_Portrait)
		{
			var gabber = ctsMakeTalker(target_inst, count, "", line);
	            gabber.input_priority = !l_organic;
	            gabber.input_disable = l_organic;
	            gabber.input_autoclose = (ending == SEQEND_AUTO);
		}
            
		// SILENT SKY SPECIFIC:
        // Update talker's sprites
        /*if (target == o_PlayerImp)
        {
            if (!exists(ctsLibrarianPopup)) new (ctsLibrarianPopup);
            ctsLibrarianPopup.image_index = ds_map_find_value(entry, SEQI_TYPE);
            o_CtsGabberBox.input_actor = null;
        }*/
        
        // Make the target face the input direction
        if (exists(target_inst))
        {
            //if (facing == -1 || facing == 1)
			if (facing == SEQI_FACING_UP)
				target_inst.facingDirection = 90;
			else if (facing == SEQI_FACING_DOWN)
				target_inst.facingDirection = 270;
			else if (facing == SEQI_FACING_LEFT)
				target_inst.facingDirection = 180;
			else if (facing == SEQI_FACING_RIGHT)
				target_inst.facingDirection = 0;
            //{
            //    target_inst.facingDir = facing;
            //}
            else if (exists(facing))
            {
                //target_inst.facingDir = sign(facing.x - target_inst.x);
				target_inst.facingDirection = point_direction(target_inst.x, target_inst.y, facing.x, facing.y);
            }
        }
        
        // On the next step
        cts_execute_state = 1;
		
		// Debug output
		debugOut("Doing lines...");
    }
    // No longer exists? We go to the enxt entry.
    //else if (!exists(o_CtsTalkerBox) && !exists(o_CtsGabberBox))
	else if (  (!exists(o_CtsTalkerBox) /*|| o_CtsTalkerBox.input_fadeout*/)
			&& (!exists(o_CtsGabberBox) || (instance_number(o_CtsGabberBox) == 1 && o_CtsGabberBox.input_fadeout))  )
    {
        cts_entry_current++;
        cts_execute_state = 0;   
    }
    break;
    
case SEQTYPE_CHOICES:
    if (cts_execute_state == 0)
    {
        // Make a talker with all the input info
        var count = ds_map_find_value(entry, SEQI_COUNT);
		var target = ds_map_find_value(entry, SEQI_TARGET);
		
		var target_inst = instance_find(target, 0);
        
        var gabber = new(o_CtsChoiceBox);
            gabber.input_choice_count = count;
            for (var i = 0; i < count; ++i)
            {
                gabber.input_choice[i] = ds_map_find_value(entry, i+1);
            }
			gabber.input_actor = exists(target_inst) ? target_inst : null;
			
        // On the next step
        cts_execute_state = 1;
		
		// Debug output
		debugOut("Doing choices...");
		
        return false;
    }
    // No longer exists? We go to the enxt entry.
    else if (!exists(o_CtsChoiceBox))
    {
        cts_entry_current++;
        cts_execute_state = 0;   
    }
	// Still exists? We should check for gotos...
    else
    {
		if (cutsceneIsChoiceReady())
		{
			var choice = cutsceneGetChoice();
			// Check the "goto" key for the choice.
			var goto = ds_map_find_value(entry, choice + 1 + SEQI_JUMP_OFFSET);
			if (goto != undefined)
			{
				if (!cutsceneJumpToLabel(goto))
				{
					// Show error about this label
					show_error("Could not find the label \"" + target + "\" in the sequence.", false);
					// We're done here. Onto the next event
					cts_entry_current++;
				    cts_execute_state = 0;
				}
			}
		}
        return false;
    }
    break;

case SEQTYPE_SCREEN:
	if (cts_execute_state == 0)
    {
		var type = ds_map_find_value(entry, SEQI_TYPE);
		var r = ds_map_find_value(entry, SEQI_SCREEN_R);
        var g = ds_map_find_value(entry, SEQI_SCREEN_G);
        var b = ds_map_find_value(entry, SEQI_SCREEN_B);
		
		if (type == SEQSCREEN_FADEIN)
		{
			var fadein = new(o_fxFadeInBanded);
				fadein.image_blend = make_color_rgb(r, g, b);
				
			cts_execute_state = 1;
		}
		else if (type == SEQSCREEN_FADEOUT)
		{
			var fadein = new(o_fxFadeOutBanded);
				fadein.image_blend = make_color_rgb(r, g, b);
				
			cts_execute_state = 1;
		}
		else if (type == SEQSCREEN_HOLD)
		{
			var hold = new(o_fxFadeHold);
				hold.image_blend = make_color_rgb(r, g, b);
				
			cts_execute_state = 1;
		}
		else if (type == SEQSCREEN_CTSIN)
		{
			ctsShowBars();
			cts_entry_current++;
			cts_execute_state = 0;   
		}
		else if (type == SEQSCREEN_CTSOUT)
		{
			ctsHideBars();
			cts_entry_current++;
			cts_execute_state = 0;   
		}
		else if (type == SEQSCREEN_SHAKE)
		{
			effectScreenShake(ds_map_find_value(entry, SEQI_SCREEN_SHAKE),
							  ds_map_find_value(entry, SEQI_SCREEN_LENGTH),
							  true);
			cts_entry_current++;
			cts_execute_state = 0;   
		}
		else
		{
			cts_execute_state = 1;
		}
		
		// Debug output
		debugOut("Doing screen effect...");
	}
	// No longer exists? We go to the enxt entry.
    else
	{
		var type = ds_map_find_value(entry, SEQI_TYPE);
		
		if (type == SEQSCREEN_FADEIN)
		{
			if (!exists(o_fxFadeInBanded))
		    {
		        cts_entry_current++;
		        cts_execute_state = 0;   
		    }
		}
		else if (type == SEQSCREEN_FADEOUT)
		{
			if (o_fxFadeOutBanded.image_alpha > 1.1)
			{
				cts_entry_current++;
			    cts_execute_state = 0;   
			}
		}
		else if (type == SEQSCREEN_HOLD)
		{	// continue to next sequence
			cts_entry_current++;
			cts_execute_state = 0;   
		}
		else
		{
			cts_entry_current++;
			cts_execute_state = 0;   
		}
	}
	break;
	
case SEQTYPE_AUDIO:
	var file = ds_map_find_value(entry, SEQI_AUDIO_FILE);
	var stop = ds_map_find_value(entry, SEQI_AUDIO_STOP);
	var looped = ds_map_find_value(entry, SEQI_AUDIO_LOOP);
	var streamed = ds_map_find_value(entry, SEQI_AUDIO_STREAMED);
	
	if (file != "none")
	{
		faudio_play_file(file, streamed, looped);
	}
	if (stop != "none")
	{
		// TODO: find the sounds that match the file and delete em
	}
	
	// Debug output
	debugOut("Doing audio...");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_MUSIC:
	var type = ds_map_find_value(entry, SEQI_TYPE);
	if (type == SEQMUSIC_PLAY)
	{
		var music = fmusic_create();
		var max_i = ds_map_find_value(entry, SEQI_MUSIC_TRACKCOUNT);
		// Create the tracks
		for (var i = 0; i < max_i; ++i)
		{
			fmusic_add_track(music, ds_map_find_value(entry, i));
		}
		fmusic_start(music);
		
		// Set the volume
		for (var i = 0; i < music.m_trackCount; ++i)
		{
			music.m_trackVolume[i] = ds_map_find_value(entry, i + SEQI_MUSIC_OFFSET);
		}
	}
	else if (type == SEQMUSIC_UPDATE)
	{
		with (ob_musicPlayer)
		{
			if (m_fadeOut) continue;
			
			// Set the volume
			for (var i = 0; i < m_trackCount; ++i)
			{
				m_trackVolume[i] = ds_map_find_value(entry, i + SEQI_MUSIC_OFFSET);
			}
		}
	}
	
	// Debug output
	debugOut("Doing music...");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_GOTO:
	var target = ds_map_find_value(entry, SEQI_TARGET);
	if (target != undefined)
	{
		if (!cutsceneJumpToLabel(target))
		{
			// Show error about this label
			show_error("Could not find the label \"" + target + "\" in the sequence.", false);
			// We're done here. Onto the next event
			cts_entry_current++;
		    cts_execute_state = 0;
		}
	}
	else
	{
		// We're done here. Onto the next event
		cts_entry_current++;
	    cts_execute_state = 0;
	}
	
	// Debug output
	debugOut("Doing goto...");

	break;
	
case SEQTYPE_PALETTE:
	var type = ds_map_find_value(entry, SEQI_TYPE);
	
	// Change the palette
	paletteSetCurrent(type);
	
	// Debug output
	debugOut("Doing palette change to " + string(type) + "..."); 
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_SIGNAL:
	// Change the palette
	cts_last_signal = ds_map_find_value(entry, SEQI_ID);
	cts_last_signal_consumed = false;
	
	// Debug output
	debugOut("Doing signal " + cts_last_signal + "...");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_AI:
	// Pull common params
	var count = ds_map_find_value(entry, SEQI_COUNT);
    var target = ds_map_find_value(entry, SEQI_TARGET);
    var style = ds_map_find_value(entry, SEQI_AI_STYLE);
        
	// Find target
    var target_inst = instance_find(target, count);

	// Apply the AI command
	var command = ds_map_find_value(entry, SEQI_AI_COMMAND);
	switch (command)
	{
		case kAiRequestCommand_Start:
			aiscriptRequestStart(target_inst, style);
			aiscriptRequestPushPosition(target_inst,
										ds_map_find_value(entry, SEQI_AI_POS_X),
										ds_map_find_value(entry, SEQI_AI_POS_Y));
			break;
		case kAiRequestCommand_Stop:
			aiscriptRequestStop(target_inst, style);
			break;
		case kAiRequestCommand_Animation:
			aiscriptRequestAnimation(target_inst, style,
									 ds_map_find_value(entry, SEQI_AI_ANIMATION),
									 ds_map_find_value(entry, SEQI_AI_LOOPED),
									 ds_map_find_value(entry, SEQI_AI_SPEED));
			break;
		case kAiRequestCommand_Move:
			var origin = ds_map_find_value(entry, SEQI_AI_POS_ORIGIN);
			var tx = ds_map_find_value(entry, SEQI_AI_POS_X);
			var ty = ds_map_find_value(entry, SEQI_AI_POS_Y);
			if (exists(origin))
			{
				tx += origin.x;
				ty += origin.y;
			}
			aiscriptRequestMove(target_inst, style,
								tx, ty,
								ds_map_find_value(entry, SEQI_AI_SPEED));
			break;
		case kAiRequestCommand_Teleport:
			var origin = ds_map_find_value(entry, SEQI_AI_POS_ORIGIN);
			var tx = ds_map_find_value(entry, SEQI_AI_POS_X);
			var ty = ds_map_find_value(entry, SEQI_AI_POS_Y);
			if (exists(origin))
			{
				tx += origin.x;
				ty += origin.y;
			}
			aiscriptRequestTeleport(target_inst, style,
									tx, ty);
			break;
		case kAiRequestCommand_Face:
			var origin = ds_map_find_value(entry, SEQI_AI_POS_ORIGIN);
			var tx = ds_map_find_value(entry, SEQI_AI_POS_X);
			var ty = ds_map_find_value(entry, SEQI_AI_POS_Y);
			if (exists(origin))
			{
				tx += origin.x;
				ty += origin.y;
			}
			aiscriptRequestFace(target_inst, style,
								tx, ty);
			break;
	}

	// Debug output
	debugOut("Doing AI command " + string(command) + " in style " + string(style) + "...");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_EMOTE:
	// Pull common params
	var count = ds_map_find_value(entry, SEQI_COUNT);
    var target = ds_map_find_value(entry, SEQI_TARGET);
    var emote = ds_map_find_value(entry, SEQI_TYPE); 
        
	// Find target
    var target_inst = instance_find(target, count);
	
	// Create the emote
	var emote_fx = new(o_fxEmote);
		emote_fx.m_target = target_inst;
		emote_fx.image_index = emote;
	
	// Debug output
	debugOut("Doing emote type " + string(emote) + "..."); 
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_FLAGS:
	// Change the palette
	var quest_id = ds_map_find_value(entry, SEQI_ID);
	var quest_value = ds_map_find_value(entry, SEQI_TIME);
	
	questSetValue(quest_id, quest_value);
	
	// Debug output
	debugOut("Doing flag set [" + string(quest_id) + "] to " + string(quest_value) + "...");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	
	// Set as a no-frame event
	return _cutsceneUpdateNoFrame();
	break;
	
case SEQTYPE_WORLD:
	var command = ds_map_find_value(entry, SEQI_WORLD_COMMAND);
	var arg = ds_map_find_value(entry, SEQI_WORLD_CMD_ARG);
	
	if (command == SEQWORLD_TIME)
	{
		worldSetTimeRunning((arg != -1) ? arg : true);
	}
	else if (command = SEQWORLD_EVENT)
	{
		worldEventCreate(arg);
	}
	
	// Debug out
	debugOut("Doing world command [" + string(command) + "](" + string(arg) + ")");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_PORTRAIT:
	var index = ds_map_find_value(entry, SEQI_PORTRAIT_INDEX);
	var action = ds_map_find_value(entry, SEQI_PORTRAIT_ACTION);
	var position = ds_map_find_value(entry, SEQI_PORTRAIT_POS);
	var alignment = ds_map_find_value(entry, SEQI_PORTRAIT_ALIGNMENT);
	//var character = ds_map_find_value(entry, SEQI_TARGET);
	//var face = ds_map_find_value(entry, SEQI_PORTRAIT_FACE);
	var sprite = ds_map_find_value(entry, SEQI_PORTRAIT_SPRITE);
	var facing = ds_map_find_value(entry, SEQI_PORTRAIT_FACING);

	if (action == kPortraitActionShow)
	{
		ctsPortraitShowImage(index, sprite, position, alignment, facing);
	}
	else if (action = kPortraitActionHide)
	{
		ctsPortraitShowImage(index, null, 0, 0, 0);
	}
	else if (action = kPortraitActionHideAll)
	{
		for (var i = 0; i < kPortraitIndex_Max; ++i)
		{
			ctsPortraitShowImage(i, null, 0, 0, 0);
		}
	}

	// Debug out
	debugOut("Doing portrait...");
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
}

return true;

