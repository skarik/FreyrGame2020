/// @description cutsceneLoad(cutscene_file)
/// @param cutscene_file {String} Filename in CTS directory.
cutsceneInit();

var filename = argument0;

var fp = fioTextOpenRead("cts/" + filename);
if (fp == -1)
{
    show_error("Could not find the cutscene '" + filename + "' for open.", true);
    return null;
}
var STATE_BEGIN = 0, STATE_READ_LINES = 1, STATE_READ_BEGIN_OBJECT = 2, STATE_READ_OBJECT = 3;

var read_state = STATE_BEGIN;
var read_object_type = SEQTYPE_NULL;
var read_object_map = null;

var read_state_line = "";
var read_state_line_length = 0;
var read_state_get_next_line = true;
var read_state_cursor = 0;

// Read in until EOF
while (!file_text_eof(fp))
{
	if (read_state_get_next_line)
	{
		read_state_line = file_text_readln(fp);
		read_state_line_length = string_length(read_state_line);
		read_state_cursor = 1;
		
		read_state_get_next_line = false;
	}
	
    /*var line = file_text_readln(fp);
    // Cut off the space from the start of it
    line = string_rtrim(string_ltrim(line));
    // Cut off any '//' that is found
    line = string_rtrim_comment(line);*/
	
	var line = "";
#region Parse lines into virtual lines
	// read past all the spaces until we hit a character
	while (read_state_cursor <= read_state_line_length 
		&& is_space(string_char_at(read_state_line, read_state_cursor)))
	{
		read_state_cursor++;
	}
	// empty line? 
	if (read_state_cursor >= read_state_line_length)
	{
		read_state_get_next_line = true;
	}
	else
	{
		// read in the line we're looking at
		while (read_state_cursor <= read_state_line_length
			&& !(read_state_cursor + 1 <= read_state_line_length && string_char_at(read_state_line, read_state_cursor + 0) == "/" && string_char_at(read_state_line, read_state_cursor + 1) == "/")
			&& string_char_at(read_state_line, read_state_cursor) != "\r"
			&& string_char_at(read_state_line, read_state_cursor) != "\n"
			&& string_char_at(read_state_line, read_state_cursor) != ";"
			&& string_char_at(read_state_line, read_state_cursor) != "{"
			&& string_char_at(read_state_line, read_state_cursor) != "}"
			&& !(read_state_cursor + 1 <= read_state_line_length && string_char_at(read_state_line, read_state_cursor + 1) == "{")
			&& !(read_state_cursor + 1 <= read_state_line_length && string_char_at(read_state_line, read_state_cursor + 1) == "}")
			)
		{
			line += string_char_at(read_state_line, read_state_cursor);
			read_state_cursor++;
		}
		// Is the rest of the line bunk?
		if ((read_state_cursor + 1 <= read_state_line_length && string_char_at(read_state_line, read_state_cursor + 0) == "/" && string_char_at(read_state_line, read_state_cursor + 1) == "/")
			|| string_char_at(read_state_line, read_state_cursor) == "\r"
			|| string_char_at(read_state_line, read_state_cursor) == "\n")
		{
			read_state_get_next_line = true;
		}
		// Is this a one-character stop and we need to force a move-on
		if (string_length(line) == 0 && read_state_cursor <= read_state_line_length 
			&& (string_char_at(read_state_line, read_state_cursor) == ";"
			|| string_char_at(read_state_line, read_state_cursor) == "{"
			|| string_char_at(read_state_line, read_state_cursor) == "}"))
		{
			line += string_char_at(read_state_line, read_state_cursor);
			read_state_cursor++;
		}
	}
	// Cut off any extra space that is hanging around that are not displayable
	line = string_rtrim(string_ltrim(line));
#endregion
	//show_debug_message("source: " + string_rtrim(string_ltrim(read_state_line)));
	//show_debug_message("parsed: " + line);

    if (read_state == STATE_BEGIN)
    {
        // Read in lines until we hit the #begin macro
        if (string_pos("#begin", line) != 0)
        {
            read_state = STATE_READ_LINES;
            continue;
        }
    }
    if (read_state == STATE_READ_LINES)
    {
        // We read line by line, looking for some actual info
        if (string_length(line) == 0) continue;
        // Ended tag stops everything
        if (string_pos("#ended", line) != 0) break;
        
        // Check for object types
        read_object_type = SEQTYPE_NULL;
		if (string_pos("#", line) == 1)
		{
			read_object_type = SEQTYPE_LABEL;
			// Labels are special. They need to be added immediately.
			if (read_object_type == SEQTYPE_LABEL)
			{
				// Save the entry as a string
	            cts_entry[cts_entry_count] = string_copy(line, 2, string_length(line) - 1);
	            cts_entry_type[cts_entry_count] = SEQTYPE_LABEL;
	            cts_entry_count++;
				// Go to the next line state
				read_state = STATE_READ_LINES;
				// Show debug info
				debugOut("Adding label \"" + cts_entry[cts_entry_count - 1] + "\"");
	            continue;
			}
		}
        else if (string_pos("lines", line) == 1)
        {
            read_object_type = SEQTYPE_LINES;
        }
        else if (string_pos("choice", line) == 1)
        {
            read_object_type = SEQTYPE_CHOICES;
        }
        else if (string_pos("wait", line) == 1)
        {
            read_object_type = SEQTYPE_WAIT;
        }
		else if (string_pos("screen", line) == 1)
		{
			read_object_type = SEQTYPE_SCREEN;
		}
		else if (string_pos("audio", line) == 1)
		{
			read_object_type = SEQTYPE_AUDIO;
		}
		else if (string_pos("music", line) == 1)
		{
			read_object_type = SEQTYPE_MUSIC;
		}
		else if (string_pos("goto_if_companion", line) == 1)
		{
			read_object_type = SEQTYPE_GOTO_IF_COMPANION;
		}
		else if (string_pos("goto_if_flag", line) == 1)
		{
			read_object_type = SEQTYPE_GOTO_IF_FLAG;
		}
		else if (string_pos("goto", line) == 1)
		{
			read_object_type = SEQTYPE_GOTO;
		}
        else if (string_pos("palette", line) == 1)
		{
			read_object_type = SEQTYPE_PALETTE;	
		}
		else if (string_pos("signal", line) == 1)
		{
			read_object_type = SEQTYPE_SIGNAL;	
		}
		else if (string_pos("ai", line) == 1)
		{
			read_object_type = SEQTYPE_AI;
		}
		else if (string_pos("companion", line) == 1)
		{
			read_object_type = SEQTYPE_COMPANION;
		}
		else if (string_pos("spawnstate", line) == 1)
		{
			read_object_type = SEQTYPE_SPAWNSTATE;
		}
		else if (string_pos("emote", line) == 1)
		{
			read_object_type = SEQTYPE_EMOTE;
		}
		else if (string_pos("flags", line) == 1)
		{
			read_object_type = SEQTYPE_FLAGS;
		}
		else if (string_pos("world", line) == 1)
		{
			read_object_type = SEQTYPE_WORLD;
		}
		else if (string_pos("portrait", line) == 1)
		{
			read_object_type = SEQTYPE_PORTRAIT;
		}
		else if (string_pos("giveitem", line) == 1)
		{
			read_object_type = SEQTYPE_GIVEITEM;
		}
		else if (string_pos("player", line) == 1)
		{
			read_object_type = SEQTYPE_PLAYER;
		}
		
        // If an object was read - prepare to read it in
        if (read_object_type != SEQTYPE_NULL)
        {
            read_state = STATE_READ_BEGIN_OBJECT;
            continue;
        }
        
    }
    if (read_state == STATE_READ_BEGIN_OBJECT)
    {   // Look for opening bracket
	    if (string_pos("{", line) != 0)
	    {
	        // Create map
	        read_object_map = ds_map_create();
	        // Go to read object state
	        read_state = STATE_READ_OBJECT;
	        continue;
	    }
    }
    if (read_state == STATE_READ_OBJECT)
    {
        // Object has ended - finalize it.
        if (string_pos("}", line) != 0)
        {
            if (read_object_type == SEQTYPE_CHOICES)
            {
                var actual_map = ds_map_create();
				
				var target = ds_map_find_value(read_object_map, "target");
                target = _cutsceneParseTarget(target);
					
				var name = ds_map_find_value(read_object_map, "id");
				
				// Loop through the numbered keys for choices:
				var key = 1;
				var max_key = 0;
				while (!is_undefined(ds_map_find_value(read_object_map, string(key))))
				{
					// Select max key for the count later
                    max_key = max(max_key, key);
					// Add the actual key
                    ds_map_add(actual_map, key, ds_map_find_value(read_object_map, string(key)));
					// Find if there is jump information
					var jump_key = string(key) + "goto";
					if (ds_map_exists(read_object_map, jump_key))
					{	// Save the jump information if there is
						ds_map_add(actual_map, key + SEQI_JUMP_OFFSET, ds_map_find_value(read_object_map, jump_key));
					}
					// Incremenent key
					key += 1;
				}
                // Add the key count
                ds_map_add(actual_map, SEQI_COUNT, max_key);
				
				// Add the target
				ds_map_add(actual_map, SEQI_TARGET, target);
				
				// Add the ID
				ds_map_add(actual_map, SEQI_ID, name);
                
                // Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = actual_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_CHOICES;
                cts_entry_count++;
            }
            else if (read_object_type == SEQTYPE_LINES)
            {
                // We actually need to make multiple objects
                // First grab the target
                var target = ds_map_find_value(read_object_map, "target");
                target = _cutsceneParseTarget(target);
				
                var object = ds_map_find_value(read_object_map, "object");
                if (is_undefined(object))
                    object = "0";
                    
                var ending = ds_map_find_value(read_object_map, "end");
                if (is_undefined(ending))
                    ending = SEQEND_NONE;
                else if (ending == "auto")
                    ending = SEQEND_AUTO;
                else if (ending == "timed" || ending == "organic")
                    ending = SEQEND_ORGANIC;
                else
                    ending = SEQEND_NONE;
                    
                var facing = ds_map_find_value(read_object_map, "facing");
                if (is_undefined(facing))
                    facing = null;
                else if (facing == "left")
                    facing = SEQI_FACING_LEFT;
                else if (facing == "right")
                    facing = SEQI_FACING_RIGHT;
				else if (facing == "down")
                    facing = SEQI_FACING_DOWN;
				else if (facing == "up")
                    facing = SEQI_FACING_UP;
				else
					facing = _cutsceneParseTarget(facing);
					
				var style = ds_map_find_value(read_object_map, "style");
				if (is_undefined(style))
					style = kLinesStyle_Default;
				else if (style == "portrait")
					style = kLinesStyle_Portrait;
				else if (style == "diegetic")
					style = kLinesStyle_Diagetic;
				else if (style == "tutorial")
					style = kLinesStyle_Tutorial;
				else if (style == "mumble")
					style = kLinesStyle_Mumble;
				else
					style = kLinesStyle_Default;
					
				var tail_unparsed = read_object_map[?"tail"];
				if (is_undefined(tail_unparsed))
					tail_unparsed = "default";
				var tail_parsed = string_split(tail_unparsed, " ", true);
				var tail_mode = kLinesTail_Auto;
				var tail_x = 0.0;
				var tail_y = 0.0;
				var tail_direction = SEQI_FACING_LEFT;
				if (tail_parsed[0] == "default" || tail_parsed[0] == "auto")
					tail_mode = kLinesTail_Auto;
				else if (tail_parsed[0] == "off" || tail_parsed[0] == "none")
					tail_mode = kLinesTail_Off;
				else if (tail_parsed[0] == "position")
				{
					tail_mode = kLinesTail_Position;
					tail_x = real(tail_parsed[1]);
					tail_y = real(tail_parsed[2]);
					tail_direction = "left";
					if (array_length_1d(tail_parsed) > 3)
						tail_direction = string_lower(tail_parsed[3]);
					if (tail_direction == "left")
						tail_direction = SEQI_FACING_LEFT;
					else if (tail_direction == "right")
						tail_direction = SEQI_FACING_RIGHT;
					else if (tail_direction == "up")
						tail_direction = SEQI_FACING_UP;
					else if (tail_direction == "down")
						tail_direction = SEQI_FACING_DOWN;
					else
						tail_direction = SEQI_FACING_LEFT;
				}
                    
                // Now, loop through the input map and select lines
                var index = 0;
                while (true)
                {
                    index += 1;
                    var line = ds_map_find_value(read_object_map, string(index));
					var linec = ds_map_find_value(read_object_map, string(index) + "c");
					var linea = ds_map_find_value(read_object_map, string(index) + "a");
					var linep = ds_map_find_value(read_object_map, string(index) + "p");
                    var wave = ds_map_find_value(read_object_map, string(index) + "wav");
                    if (is_undefined(line) && is_undefined(linec)
						&& is_undefined(linea) && is_undefined(linep))
						break; // No more lines found!
                    if (is_undefined(wave)) wave = "";
                    
                    var new_map = ds_map_create();
                    ds_map_add(new_map, SEQI_LINE, line);
					if (!is_undefined(linec))
						ds_map_add(new_map, SEQI_LINE + SEQI_LINE_OFFSET_MALE, linec);
					if (!is_undefined(linea))
						ds_map_add(new_map, SEQI_LINE + SEQI_LINE_OFFSET_FEMALE, linea);
					if (!is_undefined(linep))
						ds_map_add(new_map, SEQI_LINE + SEQI_LINE_OFFSET_NONBI, linep);
                    ds_map_add(new_map, SEQI_WAV, wave);
                    ds_map_add(new_map, SEQI_TARGET, target);
                    ds_map_add(new_map, SEQI_COUNT, real(object));
                    ds_map_add(new_map, SEQI_FACING, facing);
                    ds_map_add(new_map, SEQI_ENDACTION, ending);
					ds_map_add(new_map, SEQI_STYLE, style);
					new_map[?SEQI_LINE_TAIL_TYPE] = tail_mode;
					new_map[?SEQI_LINE_TAIL_X] = tail_x;
					new_map[?SEQI_LINE_TAIL_Y] = tail_y;
					new_map[?SEQI_LINE_TAIL_DIRECTION] = tail_direction;
                    
                    // Save the new map data
                    cts_entry[cts_entry_count] = new_map;
                    cts_entry_type[cts_entry_count] = SEQTYPE_LINES;
                    cts_entry_count++;
                }
                
                // Delete original map
                ds_map_destroy(read_object_map);
            }
            else if (read_object_type == SEQTYPE_WAIT)
            {
                var name = ds_map_find_value(read_object_map, "id");
                var type = ds_map_find_value(read_object_map, "type");
                var time = ds_map_find_value(read_object_map, "time");
				var target = ds_map_find_value(read_object_map, "target");
				var targeti = ds_map_find_value(read_object_map, "object");
				var aiaction = ds_map_find_value(read_object_map, "aiaction");
				var distance = ds_map_find_value(read_object_map, "distance");
				
                if (is_undefined(name)) name = "";
                if (is_undefined(type)) type = "input";
                if (is_undefined(time)) time = "1.0";
				target = _cutsceneParseTarget(target);
				if (is_undefined(targeti)) targeti = "0";
				if (is_undefined(aiaction)) aiaction = "";
				if (is_undefined(distance)) distance = "50";
                
                var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_ID, name);
                ds_map_add(new_map, SEQI_TIME, real(time));
				ds_map_add(new_map, SEQI_TARGET, target);
				ds_map_add(new_map, SEQI_COUNT, real(targeti));
				ds_map_add(new_map, SEQI_WAIT_AIACTION, aiaction);
				ds_map_add(new_map, SEQI_WAIT_DISTANCE, real(distance));
                if (type == "time")
                    ds_map_add(new_map, SEQI_TYPE, SEQWAIT_TIME);
                else if (type == "input")
                    ds_map_add(new_map, SEQI_TYPE, SEQWAIT_INPUT);
				else if (type == "ai")
					ds_map_add(new_map, SEQI_TYPE, SEQWAIT_AI);
				else if (type == "playerdistance")
					ds_map_add(new_map, SEQI_TYPE, SEQWAIT_PLAYERDISTANCE);
				else if (type == "talkto")
					ds_map_add(new_map, SEQI_TYPE, SEQWAIT_TALKTO);
                else
                    ds_map_add(new_map, SEQI_TYPE, SEQWAIT_INPUT);
                    
                 // Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_WAIT;
                cts_entry_count++;
            }
			else if (read_object_type == SEQTYPE_SIGNAL)
            {
                var name = ds_map_find_value(read_object_map, "id");
                if (is_undefined(name)) name = "";
                
                var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_ID, name);
                    
                 // Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_SIGNAL;
                cts_entry_count++;
            }
			else if (read_object_type == SEQTYPE_SCREEN)
			{
				var type = ds_map_find_value(read_object_map, "type");
				var rgb = ds_map_find_value(read_object_map, "rgb");
				var strength = ds_map_find_value(read_object_map, "strength");
				var length = ds_map_find_value(read_object_map, "length");
				if (is_undefined(type)) type = "none";
				if (is_undefined(rgb)) rgb = "0 0 0";
				if (is_undefined(strength)) strength = "1";
				if (is_undefined(length)) length = "1";
				
				var rgb_list = string_split(rgb, " ", true);
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_SCREEN_R, real(rgb_list[0]));
                ds_map_add(new_map, SEQI_SCREEN_G, real(rgb_list[1]));
				ds_map_add(new_map, SEQI_SCREEN_B, real(rgb_list[2]));
				ds_map_add(new_map, SEQI_SCREEN_SHAKE, real(strength));
				ds_map_add(new_map, SEQI_SCREEN_LENGTH, real(length));
                if (type == "fadein")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_FADEIN);
                else if (type == "fadeout")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_FADEOUT);
				else if (type == "hold")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_HOLD);
				else if (type == "shake")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_SHAKE);
				else if (type == "ctsin")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_CTSIN);
				else if (type == "ctsout")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_CTSOUT);
                else
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_NONE);
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_SCREEN;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_AUDIO)
			{
				var file = ds_map_find_value(read_object_map, "play");
				var stop = ds_map_find_value(read_object_map, "stop");
				var loop = ds_map_find_value(read_object_map, "loop");
				var stream = ds_map_find_value(read_object_map, "stream");
				if (is_undefined(file)) file = "none";
				if (is_undefined(stop)) stop = "none";
				if (loop == "true" || loop == "1")
					loop = true;
				else
					loop = false;
				if (stream == "false" || stream == "0")
					stream = false;
				else
					stream = true;
				
				var new_map = ds_map_create();
				ds_map_add(new_map, SEQI_AUDIO_FILE, file);
				ds_map_add(new_map, SEQI_AUDIO_STOP, stop);
				ds_map_add(new_map, SEQI_AUDIO_LOOP, loop);
				ds_map_add(new_map, SEQI_AUDIO_STREAMED, stream);
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_AUDIO;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_MUSIC)
			{
				var new_map = ds_map_create();
				
				var type = SEQMUSIC_UPDATE;
				var defaultVolume = ds_map_find_value(read_object_map, "volume");
				var pitch = ds_map_find_value(read_object_map, "pitch");
				
				if (is_undefined(defaultVolume)) defaultVolume = "0.0";
				if (is_undefined(pitch)) pitch = "1.0";
				
				// Loop through the numbered keys for tracks:
				var max_i = 0;
				for (var i = 0; i < 16; ++i)
				{
					// Read in the filename key
					var key = string(i + 1);
					if (ds_map_exists(read_object_map, key))
					{
						ds_map_add(new_map, i, ds_map_find_value(read_object_map, key));
						max_i = max(max_i, i);
						type = SEQMUSIC_PLAY;
					}
					else
					{
						ds_map_add(new_map, i, undefined);
					}
					
					// Read in the volume key
					var volume_key = key + "volume";
					if (ds_map_exists(read_object_map, volume_key))
					{
						var volume = ds_map_find_value(read_object_map, volume_key);
						if (is_undefined(volume))
							volume = defaultVolume;
						else
							volume = real(volume);
						ds_map_add(new_map, i + SEQI_MUSIC_OFFSET, volume);
					}
					else
					{
						ds_map_add(new_map, i + SEQI_MUSIC_OFFSET, real(defaultVolume));
					}
				}
				
				ds_map_add(new_map, SEQI_MUSIC_TRACKCOUNT, max_i + 1);
				ds_map_add(new_map, SEQI_AUDIO_PITCH, real(pitch));
				ds_map_add(new_map, SEQI_TYPE, type);
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_MUSIC;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_GOTO
				|| read_object_type == SEQTYPE_GOTO_IF_COMPANION
				|| read_object_type == SEQTYPE_GOTO_IF_FLAG)
			{
				// Parse all values
				var target = ds_map_find_value(read_object_map, "target");
				if (is_undefined(target)) show_error("goto objects must have a 'target' field", true);
				
				var quest_id = undefined;
				var flag_value = undefined;
				var flag_compare = undefined;
				if (read_object_type == SEQTYPE_GOTO_IF_FLAG)
				{
					var quest_name = read_object_map[?"flag"];
					var quest_name = string_ltrim(string_rtrim(string_fix_whitespace(quest_name)));
					quest_id = ds_map_find_value(global.ctsBackend_QuestIds, quest_name);
					if (is_undefined(quest_id))
					{
						var error = "Could not find quest id \"" + quest_name + "\" in the listing. please check spelling";
						show_error(error, false);
						debugOut(error);
					}
					
					var flag_value = read_object_map[?"value"];
					var flag_compare = read_object_map[?"compare"];
				}
				
				var companion_with = [];
				var companion_notwith = [];
				if (read_object_type == SEQTYPE_GOTO_IF_COMPANION)
				{
					var try, with_next = undefined, notwith_next = undefined, lookup;
					
					try = 0;
					lookup = "with";
					do
					{
						with_next = read_object_map[?lookup];
						if (!is_undefined(with_next))
						{
							companion_with[array_length_1d(companion_with)] = _cutsceneParseTarget(with_next);
						}
						
						lookup = "with" + string(try);
						try++;
					}
					until (is_undefined(with_next));
					
					try = 0;
					lookup = "notwith";
					do
					{
						notwith_next = read_object_map[?lookup];
						if (!is_undefined(notwith_next))
						{
							companion_notwith[array_length_1d(companion_notwith)] = _cutsceneParseTarget(notwith_next);
						}
						
						lookup = "notwith" + string(try);
						try++;
					}
					until (is_undefined(notwith_next));
				}
				
				// Create the GOTO structure
				var new_map = ds_map_create();
				ds_map_add(new_map, SEQI_TARGET, target);
				
				if (read_object_type == SEQTYPE_GOTO_IF_FLAG)
				{
					ds_map_add(new_map, SEQI_GOTO_FLAGID, quest_id);
					ds_map_add(new_map, SEQI_GOTO_FLAGVALUE, real(flag_value));
					if (flag_compare == "==" || flag_compare == "=")
						ds_map_add(new_map, SEQI_GOTO_FLAGCOMPARE, kCompareOpEqual);
					else if (flag_compare == "!=")
						ds_map_add(new_map, SEQI_GOTO_FLAGCOMPARE, kCompareOpNotEqual);
					else if (flag_compare == ">")
						ds_map_add(new_map, SEQI_GOTO_FLAGCOMPARE, kCompareOpGreater);
					else if (flag_compare == ">=")
						ds_map_add(new_map, SEQI_GOTO_FLAGCOMPARE, kCompareOpGreaterEqual);
					else if (flag_compare == "<")
						ds_map_add(new_map, SEQI_GOTO_FLAGCOMPARE, kCompareOpLess);
					else if (flag_compare == "<=")
						ds_map_add(new_map, SEQI_GOTO_FLAGCOMPARE, kCompareOpLessEqual);
				}
				
				if (read_object_type == SEQTYPE_GOTO_IF_COMPANION)
				{
					ds_map_add(new_map, SEQI_GOTO_COMPWITH, companion_with);
					ds_map_add(new_map, SEQI_GOTO_COMPNOTWITH, companion_notwith);
				}
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = read_object_type;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_PALETTE)
			{
				var type = ds_map_find_value(read_object_map, "type");
				if (is_undefined(type)) type = "crushed";
				
				var new_map = ds_map_create();
                if (type == "wide")
                    ds_map_add(new_map, SEQI_TYPE, kPaletteWide);
                else if (type == "crushed")
                    ds_map_add(new_map, SEQI_TYPE, kPaletteCrushed);
                else
                    ds_map_add(new_map, SEQI_TYPE, kPaletteCrushed);
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_PALETTE;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_AI)
			{
				// First grab the target
				var target = ds_map_find_value(read_object_map, "target");
				target = _cutsceneParseTarget(target);
					
				var targeti = ds_map_find_value(read_object_map, "object");
				if (is_undefined(targeti))
					targeti = "0";
					
				var origin = ds_map_find_value(read_object_map, "origin");
				origin = _cutsceneParseTarget(origin);
				
				var style = ds_map_find_value(read_object_map, "style");
				if (is_undefined(style))
					style = kAiStyle_Scripted;
				else if (style == "cutscene" || style == "cts")
					style = kAiStyle_Scripted;
				else if (style == "follow")
					style = kAiStyle_Follow;
				else if (style == "lead")
					style = kAiStyle_Lead;
				else if (style == "default")
					style = kAiStyle_Default;
				else
					style = kAiStyle_Scripted;
					
				var command = ds_map_find_value(read_object_map, "command");
				if (is_undefined(command))
					command = kAiRequestCommand_Stop;
				else if (command == "stop")
					command = kAiRequestCommand_Stop;
				else if (command == "start")
					command = kAiRequestCommand_Start;
				else if (command == "anim" || command == "animation" || command == "sprite")
					command = kAiRequestCommand_Animation;
				else if (command == "move")
					command = kAiRequestCommand_Move;
				else if (command == "teleport")
					command = kAiRequestCommand_Teleport;
				else if (command == "face")
					command = kAiRequestCommand_Face;
				else if (command == "jump")
					command = kAiRequestCommand_Jump;
				else
					command = kAiRequestCommand_Stop;
				
				var position = ds_map_find_value(read_object_map, "position");
				if (is_undefined(position))
					position = "0 0";
				var position_list = string_split(position, " ", true);
				
				var animation = ds_map_find_value(read_object_map, "sprite");
				if (is_undefined(animation))
					animation = ds_map_find_value(read_object_map, "animation");
				if (is_undefined(animation))
					animation = ds_map_find_value(read_object_map, "anim");
				if (is_undefined(animation))
					animation = "";
					
				var loop = ds_map_find_value(read_object_map, "loop");
				if (loop == "true" || loop == "1")
					loop = true;
				else
					loop = false;
					
				var aspeed = ds_map_find_value(read_object_map, "speed");
				if (is_undefined(aspeed))
					aspeed = "1.0";
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_TARGET, target);
                ds_map_add(new_map, SEQI_COUNT, real(targeti));
				ds_map_add(new_map, SEQI_AI_STYLE, style);
				ds_map_add(new_map, SEQI_AI_COMMAND, command);
				ds_map_add(new_map, SEQI_AI_POS_X, real(position_list[0]));
				ds_map_add(new_map, SEQI_AI_POS_Y, real(position_list[1]));
				ds_map_add(new_map, SEQI_AI_POS_Z, 0.0);
				ds_map_add(new_map, SEQI_AI_POS_ORIGIN, origin);
				ds_map_add(new_map, SEQI_AI_ANIMATION, animation);
				ds_map_add(new_map, SEQI_AI_LOOPED, loop);
				ds_map_add(new_map, SEQI_AI_SPEED, real(aspeed));
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_AI;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_SPAWNSTATE)
			{
				var spawn_object = read_object_map[?"spawn"];
				spawn_object = _cutsceneParseTarget(spawn_object);
				var spawn2_object = read_object_map[?"spawn_ifunique"];
				spawn2_object = _cutsceneParseTarget(spawn2_object);
				var delete_object = read_object_map[?"delete"];
				delete_object = _cutsceneParseTarget(delete_object);
				
				var targeti = ds_map_find_value(read_object_map, "object");
				if (is_undefined(targeti))
					targeti = "0";
				
				var facing = ds_map_find_value(read_object_map, "facing");
                if (is_undefined(facing))
                    facing = null;
                else if (facing == "left")
                    facing = SEQI_FACING_LEFT;
                else if (facing == "right")
                    facing = SEQI_FACING_RIGHT;
				else if (facing == "down")
                    facing = SEQI_FACING_DOWN;
				else if (facing == "up")
                    facing = SEQI_FACING_UP;
				else
					facing = _cutsceneParseTarget(facing);
				
				var position = ds_map_find_value(read_object_map, "position");
				var position_special = kSpawnPositionNormal;
				if (is_undefined(position))
					position = "0 0";
				else if (position == "nearby")
				{
					position = "0 0";
					position_special = kSpawnPositionNearby;
				}
				var position_list = string_split(position, " ", true);
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_SPAWNSTATE_SPAWNOBJECT, spawn_object);
				ds_map_add(new_map, SEQI_SPAWNSTATE_SPAWNOBJECT_UNIQUE, spawn2_object);
				ds_map_add(new_map, SEQI_SPAWNSTATE_DELETEOBJECT, delete_object);
				ds_map_add(new_map, SEQI_FACING, facing);
				ds_map_add(new_map, SEQI_COUNT, real(targeti));
				ds_map_add(new_map, SEQI_SPAWNSTATE_POS_X, real(position_list[0]));
				ds_map_add(new_map, SEQI_SPAWNSTATE_POS_Y, real(position_list[1]));
				ds_map_add(new_map, SEQI_SPAWNSTATE_POS_SPECIAL, position_special);
				
				// Delete original map
                ds_map_destroy(read_object_map);
				
				// Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_SPAWNSTATE;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_COMPANION)
			{
				var target = read_object_map[?"target"];
				target = _cutsceneParseTarget(target);
				
				var targeti = read_object_map[?"object"];
				if (is_undefined(targeti))
					targeti = "0";
					
				var party = read_object_map[?"party"];
				if (is_undefined(party))
					party = null;
				else if (party == "add")
					party = 1;
				else if (party == "remove")
					party = -1;
				else
					party = null;
					
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_TARGET, target);
                ds_map_add(new_map, SEQI_COUNT, real(targeti));
				ds_map_add(new_map, SEQI_STYLE, party);
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_COMPANION;
                cts_entry_count++;
			}
            else if (read_object_type == SEQTYPE_EMOTE)
			{
				// First grab the target
				var target = ds_map_find_value(read_object_map, "target");
				target = _cutsceneParseTarget(target);
					
				var targeti = ds_map_find_value(read_object_map, "object");
				if (is_undefined(targeti))
					targeti = "0";
				
				var emote = ds_map_find_value(read_object_map, "emote");
				if (is_undefined(emote))
					emote = 0;
				else if (emote == "beat" || emote == "pause" || emote == "ellipses")
					emote = 0;
				else if (emote == "question" || emote == "what" || emote == "?")
					emote = 1;
				else if (emote == "exclamation" || emote == "notice" || emote == "!")
					emote = 2;
				else if (emote == "heart" || emote == "love")
					emote = 3;
				else
					emote = 0;
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_TARGET, target);
                ds_map_add(new_map, SEQI_COUNT, real(targeti));
				ds_map_add(new_map, SEQI_TYPE, emote);
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_EMOTE;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_FLAGS)
			{
				var set = ds_map_find_value(read_object_map, "set");
				
				var set_list = string_split(set, " ", true);
				var quest_name = string_ltrim(string_rtrim(string_fix_whitespace(set_list[0])));
				var quest_id = ds_map_find_value(global.ctsBackend_QuestIds, quest_name);
				if (is_undefined(quest_id))
				{
					var error = "Could not find quest id \"" + quest_name + "\" in the listing. please check spelling";
					show_error(error, false);
					debugOut(error);
				}
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_ID, quest_id);
                ds_map_add(new_map, SEQI_TIME, real(set_list[1]));
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_FLAGS;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_WORLD)
			{
				// Create map at the start since this one branches very quickly
				var new_map = ds_map_create();
				
				var time = ds_map_find_value(read_object_map, "time");
				var event = ds_map_find_value(read_object_map, "event");
				var waitfor = ds_map_find_value(read_object_map, "waitfor");
				if (!is_undefined(time))
				{
					if (time == "stop")
						time = 0;
					else if (time == "start")
						time = 1;
					else 
						time = -1;
						
					ds_map_add(new_map, SEQI_WORLD_COMMAND, SEQWORLD_TIME);
					ds_map_add(new_map, SEQI_WORLD_CMD_ARG, time);
				}
				else if (!is_undefined(event))
				{
					if (event == "riftpulse")
						event = kWorldEvent_Riftpulse;
					else if (event == "makePlayerShirtless")
						event = kWorldEvent_MakePlayerShirtless;
					else if (event == "makePlayerShirtmore")
						event = kWorldEvent_MakePlayerShirtmore;
					else
						event = kWorldEvent_NoEvent;
					
					ds_map_add(new_map, SEQI_WORLD_COMMAND, SEQWORLD_EVENT);
					ds_map_add(new_map, SEQI_WORLD_CMD_ARG, event);
				}
				else if (!is_undefined(waitfor))
				{
					if (waitfor == "night")
						waitfor = 20.00;
					else
						waitfor = -1;
					
					new_map[?SEQI_WORLD_COMMAND] = SEQWORLD_WAITFOR;
					new_map[?SEQI_WORLD_CMD_ARG] = waitfor;
				}
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_WORLD;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_PLAYER)
			{
				var actions = read_object_map[?"actions"];
				
				if (is_undefined(actions)) actions = "none";
				if (actions == "lock")
					actions = kCtsPlayerActions_Lock;
				else if (actions == "unlock")
					actions = kCtsPlayerActions_Unlock;
				else
					actions = kCtsPlayerActions_None;
				
				var new_map = ds_map_create();
				new_map[?0] = actions;
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_PLAYER;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_PORTRAIT)
			{
				var index = ds_map_find_value(read_object_map, "index");
				if (is_undefined(index))
					index = "0";
					
				var action = ds_map_find_value(read_object_map, "action");
				if (is_undefined(action))
					action = kPortraitActionShow;
				else if (action == "show")
					action = kPortraitActionShow;
				else if (action == "hide")
					action = kPortraitActionHide;
				else if (action == "hideall")
					action = kPortraitActionHideAll;
				else if (action == "move")
					action = kPortraitActionMove;
				else
					action = kPortraitActionShow;
					
				var position = ds_map_find_value(read_object_map, "position");
				if (is_undefined(position))
					position = ds_map_find_value(read_object_map, "pos");
				if (is_undefined(position))
					position = "0.0";
				
				var alignment = ds_map_find_value(read_object_map, "alignment");
				if (is_undefined(alignment))
					alignment = ds_map_find_value(read_object_map, "align");
				if (is_undefined(alignment))
					alignment = "";
				if (alignment == "left")
					alignment = kPortraitAlignLeft;
				else if (alignment == "right")
					alignment = kPortraitAlignRight;
				else if (alignment == "center")
					alignment = kPortraitAlignCenter;
				else
					alignment = kPortraitAlignLeft;
				
				var character = ds_map_find_value(read_object_map, "character");
				character = _cutsceneParseTarget(character);
				
				var expression = ds_map_find_value(read_object_map, "expression");
				if (is_undefined(expression))
					expression = "";
				if (expression == "neutral")
					expression = kPortraitExpressionNeutral;
				else if (expression == "question" || expression == "questioning")
					expression = kPortraitExpressionQuestioning;
				else
					expression = kPortraitExpressionNeutral;
					
				var facing = ds_map_find_value(read_object_map, "facing");
				if (is_undefined(facing))
					facing = ds_map_find_value(read_object_map, "face");
				if (is_undefined(facing))
					facing = 1.0;
				else if (facing == "left")
					facing = 1.0;
				else if (facing == "right")
					facing = -1.0;
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_PORTRAIT_INDEX, index);
				ds_map_add(new_map, SEQI_PORTRAIT_ACTION, action);
				ds_map_add(new_map, SEQI_PORTRAIT_POS, real(position));
				ds_map_add(new_map, SEQI_PORTRAIT_ALIGNMENT, alignment);
				ds_map_add(new_map, SEQI_TARGET, character);
				ds_map_add(new_map, SEQI_PORTRAIT_FACING, facing);
				ds_map_add(new_map, SEQI_PORTRAIT_EXPRESSION, expression);
				ds_map_add(new_map, SEQI_PORTRAIT_SPRITE, _cutsceneParsePortrait(character, expression));
				
				// Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_PORTRAIT;
                cts_entry_count++;
			}
			else if (read_object_type == SEQTYPE_GIVEITEM)
			{
				var target = read_object_map[?"target"];
				target = _cutsceneParseTarget(target);
				var from = read_object_map[?"from"];
				from = _cutsceneParseTarget(from);
				
				var item_listing = array_create(0);
				{
					var try, item_next = undefined, lookup;
					try = 0;
					lookup = "item";
					do
					{
						item_next = read_object_map[?lookup];
						if (!is_undefined(item_next))
						{
							// item_next is split into two values
							var item_next_list = string_split(item_next, " ", true);
							// Parse out item count
							var item_count = 1;
							if (array_length_1d(item_next_list) >= 2)
							{
								item_count = real(item_next_list[1]);
							}
							// Search for the item in the object listing
							var item_name = string_lower(item_next_list[0]);
							var item = null;
							for (var i = 0; i < 9999; ++i)
							{
								if (object_exists(i))
								{
									var test_object_name = string_lower(object_get_name(i));
									if (string_pos("o_pickup", test_object_name) != 0)
									{
										if (string_pos(item_name, test_object_name) != 0)
										{
											item = i;
										}
									}
								}
							}
							if (item == null)
							{
								var error = "Could not find item id \"" + item_name + "\" in the bank. please check spelling";
								show_error(error, false);
								debugOut(error);
							}
							// Save item in the listing
							item_listing[array_length_1d(item_listing)] = [item, item_count];
						}
						
						lookup = "item" + string(try);
						try++;
					}
					until (is_undefined(item_next));
				}
				
				// Create the GOTO structure
				var new_map = ds_map_create();
				new_map[?SEQI_TARGET] = target;
				new_map[?SEQI_GIVEITEM_FROM] = from;
				new_map[?SEQI_GIVEITEM_LISTING] = item_listing;
				
				// Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_GIVEITEM;
                cts_entry_count++;
			}
			
			
            read_state = STATE_READ_LINES;
            continue;
        }
       
        // Fix whitespace:
        line = string_fix_whitespace(line);
        
        // Otherwise, read keyvalues, with specific behavior based on the type of object we're reading
        // All keyvalues take the form KEY VALUE. KEY is a single word. VALUE is everything else.
        var sep = string_pos(" ", line);
        var key = string_copy(line, 1, sep - 1);
        var value = string_copy(line, sep+1, string_length(line) - sep);
        value = string_rtrim(string_ltrim(value)); // Get rid of extra whitespace
        
		// Skip empty keys
		if (string_length(key) <= 0)
		{
			continue;
		}
		
        // Add the values to the ds_map
        if (!ds_map_add(read_object_map, key, value))
        {
            debugOut("Sequence file had duplicate keys: \"" + key + "\"");
			var try = 0;
			while (!ds_map_add(read_object_map, key + string(try), value))
			{
				try += 1;
			}
			debugOut("Renamed as \"" + key + string(try) + "\" and added.");
        }
    }
}

// Add the ended tag
{
	// Save the entry as a string
	cts_entry[cts_entry_count] = "ended";
	cts_entry_type[cts_entry_count] = SEQTYPE_LABEL;
	cts_entry_count++;
}

file_text_close(fp);

