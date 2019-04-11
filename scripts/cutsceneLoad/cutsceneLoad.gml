/// @description Cutscene_Load(cutscene_file);
/// @param cutscene_file
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

// Read in until EOF
while (!file_text_eof(fp))
{
    var line = file_text_readln(fp);
    // Cut off the space from the start of it
    line = string_rtrim(string_ltrim(line));
    // Cut off any '//' that is found
    line = string_rtrim_comment(line);

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
        if (string_pos("lines", line) != 0)
        {
            read_object_type = SEQTYPE_LINES;
        }
        else if (string_pos("choice", line) != 0)
        {
            read_object_type = SEQTYPE_CHOICES;
        }
        else if (string_pos("wait", line) != 0)
        {
            read_object_type = SEQTYPE_WAIT;
        }
		else if (string_pos("screen", line) != 0)
		{
			read_object_type = SEQTYPE_SCREEN;
		}
		else if (string_pos("audio", line) != 0)
		{
			read_object_type = SEQTYPE_AUDIO;
		}
		else if (string_pos("music", line) != 0)
		{
			read_object_type = SEQTYPE_MUSIC;
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
                if (is_undefined(target))
                    target = null;
                else if (target == "imp")
                    target = o_PlayerImp;
				else if (target == "hero" || target == "player" || target == "idiot")
					target = o_PlayerTest;
				else if (target = "nathan")
					target = o_chNathan;
                else
                    target = null;
					
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
                if (is_undefined(target))
                    target = null;
                else if (target == "imp")
                    target = o_PlayerImp;
				else if (target == "hero" || target == "player" || target == "idiot")
					target = o_PlayerTest;
				else if (target = "nathan")
					target = o_chNathan;
                else
                    target = null;
                var targeti = ds_map_find_value(read_object_map, "targeti");
                if (is_undefined(targeti))
                    targeti = "0";
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
                    facing = 0;
                else if (facing == "left")
                    facing = -1;
                else if (facing == "right")
                    facing = 1;
                else if (facing == "imp")
                    facing = o_PlayerImp;
				else if (target == "hero" || target == "player" || target == "idiot")
					target = o_PlayerTest;
				else if (target = "nathan")
					target = o_chNathan;
                else
                    facing = null;
                    
                // Now, loop through the input map and select lines
                var index = 0;
                while (true)
                {
                    index += 1;
                    var line = ds_map_find_value(read_object_map, string(index));
                    var wave = ds_map_find_value(read_object_map, string(index)+"wav");
                    if (is_undefined(line)) break; // No more lines found!
                    if (is_undefined(wave)) wave = "";
                    
                    var new_map = ds_map_create();
                    ds_map_add(new_map, SEQI_LINE, line);
                    ds_map_add(new_map, SEQI_WAV, wave);
                    ds_map_add(new_map, SEQI_TARGET, target);
                    ds_map_add(new_map, SEQI_TYPE, real(targeti));
                    ds_map_add(new_map, SEQI_COUNT, real(object));
                    ds_map_add(new_map, SEQI_FACING, facing);
                    ds_map_add(new_map, SEQI_ENDACTION, ending);
                    
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
                if (is_undefined(name)) name = "";
                if (is_undefined(type)) type = "input";
                if (is_undefined(time)) time = "1.0";
                
                var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_ID, name);
                ds_map_add(new_map, SEQI_TIME, real(time));
                if (type == "time")
                    ds_map_add(new_map, SEQI_TYPE, SEQWAIT_TIME);
                else if (type == "input")
                    ds_map_add(new_map, SEQI_TYPE, SEQWAIT_INPUT);
                else
                    ds_map_add(new_map, SEQI_TYPE, SEQWAIT_INPUT);
                    
                 // Delete original map
                ds_map_destroy(read_object_map);
                
                // Save the new map data
                cts_entry[cts_entry_count] = new_map;
                cts_entry_type[cts_entry_count] = SEQTYPE_WAIT;
                cts_entry_count++;
            }
			else if (read_object_type == SEQTYPE_SCREEN)
			{
				var type = ds_map_find_value(read_object_map, "type");
				var r = ds_map_find_value(read_object_map, "r");
				var g = ds_map_find_value(read_object_map, "g");
				var b = ds_map_find_value(read_object_map, "b");
				if (is_undefined(type)) type = "none";
				if (is_undefined(r)) r = "0";
				if (is_undefined(g)) g = "0";
				if (is_undefined(b)) b = "0";
				
				var new_map = ds_map_create();
                ds_map_add(new_map, SEQI_SCREEN_R, real(r));
                ds_map_add(new_map, SEQI_SCREEN_G, real(g));
				ds_map_add(new_map, SEQI_SCREEN_B, real(b));
                if (type == "fadein")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_FADEIN);
                else if (type == "fadeout")
                    ds_map_add(new_map, SEQI_TYPE, SEQSCREEN_FADEOUT);
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
        
        // Add the values to the ds_map
        if (!ds_map_add(read_object_map, key, value))
        {
            debugOut("Sequence file had duplicate keys!");
        }
    }
}

file_text_close(fp);

