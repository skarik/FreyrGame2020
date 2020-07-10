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
		var type = ds_map_find_value(entry, SEQI_TYPE);
        if (type == SEQWAIT_TIME)
        {   // Increment timer and check for max time
            cts_execute_timer += Time.dt;
            if (cts_execute_timer > ds_map_find_value(entry, SEQI_TIME))
            {
                cts_entry_current++;
                cts_execute_state = 0;
            }
        }
		else if (type == SEQWAIT_PLAYERDISTANCE)
		{
			var target = ds_map_find_value(entry, SEQI_TARGET);
			var playerdistance = ds_map_find_value(entry, SEQI_WAIT_DISTANCE);
			
			var pl = getPlayer();
			var target = instance_find(target, 0);
			if (point_distance(pl.x, pl.y, target.x, target.y) < playerdistance)
			{
				cts_entry_current++;
                cts_execute_state = 0;
			}
		}
		else if (type == SEQWAIT_AI)
		{
			var target = ds_map_find_value(entry, SEQI_TARGET);
			var aiaction = ds_map_find_value(entry, SEQI_WAIT_AIACTION);
			
			var target = instance_find(target, 0);
			if (aiaction == "arrive")
			{
				if (point_distance(target.x, target.y, target.m_aiScript_requestPositionX, target.m_aiScript_requestPositionY) < 10)
				{
					cts_entry_current++;
					cts_execute_state = 0;
				}
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
		if (iexists(pl))
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
				gabber.input_minimal = l_organic;
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
            if (!iexists(ctsLibrarianPopup)) inew (ctsLibrarianPopup);
            ctsLibrarianPopup.image_index = ds_map_find_value(entry, SEQI_TYPE);
            o_CtsGabberBox.input_actor = null;
        }*/
        
        // Make the target face the input direction
        if (iexists(target_inst))
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
            else if (iexists(facing))
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
    //else if (!iexists(o_CtsTalkerBox) && !iexists(o_CtsGabberBox))
	else if (  (!iexists(o_CtsTalkerBox) /*|| o_CtsTalkerBox.input_fadeout*/)
			&& (!iexists(o_CtsGabberBox) || (instance_number(o_CtsGabberBox) == 1 && o_CtsGabberBox.input_fadeout))  )
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
        
        var gabber = inew(o_CtsChoiceBox);
            gabber.input_choice_count = count;
            for (var i = 0; i < count; ++i)
            {
                gabber.input_choice[i] = ds_map_find_value(entry, i+1);
            }
			gabber.input_actor = iexists(target_inst) ? target_inst : null;
			
        // On the next step
        cts_execute_state = 1;
		
		// Debug output
		debugOut("Doing choices...");
		
        return false;
    }
    // No longer exists? We go to the enxt entry.
    else if (!iexists(o_CtsChoiceBox))
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
			var fadein = inew(o_fxFadeInBanded);
				fadein.image_blend = make_color_rgb(r, g, b);
				
			cts_execute_state = 1;
		}
		else if (type == SEQSCREEN_FADEOUT)
		{
			var fadein = inew(o_fxFadeOutBanded);
				fadein.image_blend = make_color_rgb(r, g, b);
				
			cts_execute_state = 1;
		}
		else if (type == SEQSCREEN_HOLD)
		{
			var hold = inew(o_fxFadeHold);
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
			if (!iexists(o_fxFadeInBanded))
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
		faudio_play2_file(file, streamed, looped);
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
	var target = entry[?SEQI_TARGET];
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
case SEQTYPE_GOTO_IF_FLAG:
	var target = entry[?SEQI_TARGET];
	var quest_id = entry[?SEQI_GOTO_FLAGID];
	var flag_value = entry[?SEQI_GOTO_FLAGVALUE];
	var flag_compare = entry[?SEQI_GOTO_FLAGCOMPARE];
	
	var quest_value = questGetValue(quest_id);
	var check_valid = false;
	if (flag_compare == kCompareOpEqual)
	{
		check_valid = (quest_value == flag_value);
		debugOut("Check flag[" + string(quest_id) + "] " + string(quest_value) + " == " + string(flag_value));
	}
	else if (flag_compare == kCompareOpNotEqual)
	{
		check_valid = (quest_value != flag_value);
		debugOut("Check flag[" + string(quest_id) + "] " + string(quest_value) + " != " + string(flag_value));
	}
	else if (flag_compare == kCompareOpGreater)
	{
		check_valid = (quest_value > flag_value);
		debugOut("Check flag[" + string(quest_id) + "] " + string(quest_value) + " > " + string(flag_value));
	}
	else if (flag_compare == kCompareOpGreaterEqual)
	{
		check_valid = (quest_value >= flag_value);
		debugOut("Check flag[" + string(quest_id) + "] " + string(quest_value) + " >= " + string(flag_value));
	}
	else if (flag_compare == kCompareOpLess)
	{
		check_valid = (quest_value < flag_value);
		debugOut("Check flag[" + string(quest_id) + "] " + string(quest_value) + " < " + string(flag_value));
	}
	else if (flag_compare == kCompareOpLessEqual)
	{
		check_valid = (quest_value <= flag_value);
		debugOut("Check flag[" + string(quest_id) + "] " + string(quest_value) + " <= " + string(flag_value));
	}
	
	if (target != undefined && check_valid)
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
	debugOut("Doing goto_if_flag...");
	break;
case SEQTYPE_GOTO_IF_COMPANION:
	var target = entry[?SEQI_TARGET];
	var companions_with = entry[?SEQI_GOTO_COMPWITH];
	var companions_notwith = entry[?SEQI_GOTO_COMPNOTWITH];
	
	var check_valid = true;
	var party = playerPartyGetList();
	// Check all the WITH is in the party
	for (var ic = 0; ic < array_length_1d(companions_with); ++ic)
	{
		var found = false;
		for (var i = 0; i < array_length_1d(party); ++i)
		{
			if (iexists(party[i]) && companions_with[ic] == party[i].object_index)
			{
				found = true;
				break;
			}
		}
		if (!found)
		{
			check_valid = false;
		}
	}
	// Check all the NOTWITH is not in the party
	for (var ic = 0; ic < array_length_1d(companions_notwith); ++ic)
	{
		for (var i = 0; i < array_length_1d(party); ++i)
		{
			if (iexists(party[i]) && companions_notwith[ic] == party[i].object_index)
			{
				check_valid = false;
				break;
			}
		}
	}
	
	if (target != undefined && check_valid)
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
	debugOut("Doing goto_if_companion...");
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
			if (iexists(origin))
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
			if (iexists(origin))
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
			if (iexists(origin))
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
	
case SEQTYPE_SPAWNSTATE:

	var facing = entry[?SEQI_FACING];
	var spawnobject = entry[?SEQI_SPAWNSTATE_SPAWNOBJECT];
	var deleteobject = entry[?SEQI_SPAWNSTATE_DELETEOBJECT];
	
	if (iexists(spawnobject) || object_exists(spawnobject))
	{
		var target_inst = instance_create_depth(
			entry[?SEQI_SPAWNSTATE_POS_X],
			entry[?SEQI_SPAWNSTATE_POS_Y],
			0,
			spawnobject);
		
		// Make the target face the input direction
        if (iexists(target_inst))
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
            else if (iexists(facing))
            {
                //target_inst.facingDir = sign(facing.x - target_inst.x);
				target_inst.facingDirection = point_direction(target_inst.x, target_inst.y, facing.x, facing.y);
            }
        }
		
		// Debug output
		debugOut("Doing spawnstate command spawn " + object_get_name(target_inst.object_index) + "...");
	}
	else if (iexists(deleteobject) || object_exists(deleteobject))
	{
		idelete(deleteobject);
		
		// Debug output
		debugOut("Doing spawnstate command delete " + object_get_name(deleteobject) + "...");
	}
	
	// We're done here. Onto the next event
	cts_entry_current++;
    cts_execute_state = 0;
	break;
	
case SEQTYPE_COMPANION:
	// Pull common params
	var count = ds_map_find_value(entry, SEQI_COUNT);
    var target = ds_map_find_value(entry, SEQI_TARGET);
    var style = ds_map_find_value(entry, SEQI_STYLE);
	
	// Find target
    var target_inst = instance_find(target, count);
	
	// Do party command
	if (style == 1)
	{
		if (iexists(target_inst))
			playerPartyAdd(target_inst);
		else
			playerPartyAdd(target);
	}
	else if (style == -1)
	{
		if (iexists(target_inst))
			playerPartyRemove(target_inst);
		else
			playerPartyRemove(target);
	}
	else if (style == null)
	{
		debugOut("Bad companion command!");
	}

	// Debug output
	debugOut("Doing companion command " + string(target) + " in style " + string(style) + "...");
	
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
	var emote_fx = inew(o_fxEmote);
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
	var character = ds_map_find_value(entry, SEQI_TARGET);
	var face = ds_map_find_value(entry, SEQI_PORTRAIT_EXPRESSION);
	var sprite = ds_map_find_value(entry, SEQI_PORTRAIT_SPRITE);
	var facing = ds_map_find_value(entry, SEQI_PORTRAIT_FACING);
	
	sprite = cutsceneGetPortrait(character, face);

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

