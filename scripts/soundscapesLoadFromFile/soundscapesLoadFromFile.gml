/// @function sundscapesLoadFromFile( filename )
/// @desc Loads soundscapes from the given file and adds to the global storage.
/// @param filename {String} File to load from
var filename = argument0;

var fp = fioTextOpenRead(filename);
if (fp == -1)
{
    show_error("Could not find the soundscape '" + filename + "' for open.", true);
    return null;
}

var STATE_FIND_SOUNDSCAPE = 0, STATE_READ_BEGIN_SOUNDSCAPE = 1, STATE_READ_SOUNDSCAPE = 2,
		//STATE_FIND_SOUNDINFO_OR_DSP = 4, 
		STATE_READ_BEGIN_SOUNDINFO = 5, STATE_READ_SOUNDINFO = 6,
			STATE_READ_BEGIN_WAVLIST = 8, STATE_READ_WAVLIST = 9,
		STATE_READ_BEGIN_DSP = 12, STATE_READ_DSP = 13
	;

var read_state = STATE_FIND_SOUNDSCAPE;
var read_soundscape_name = "";
var read_soundscape_instance = null;
var read_soundscape_soundinfo_map = null;
var read_soundscape_dspinfo_map = null;
var read_soundinfo_instance = null;
var read_dspinfo_instance = null;

#macro kSoundscapeSoundTypeLooping 0
#macro kSoundscapeSoundTypeRandom 1

#macro kSoundChannelWorld 0
#macro kSoundChannelMusic 1
#macro kSoundChannelKey 2
#macro kSoundChannelSpeech 3
#macro kSoundChannelUi 2

#macro kSoundscapeSoundPositionBase 0
#macro kSoundscapeSoundPositionRandom -1
#macro kSoundscapeSoundPositionRandomNear -2
#macro kSoundscapeSoundPositionRandomFar -3

#macro kSoundAttenuationDefault 1.0
#macro kSoundAttenuationSpeech 0.7

// Read in until EOF
while (!file_text_eof(fp))
{
	var line = file_text_readln(fp);
    // Cut off the space from the start of it
    line = string_rtrim(string_ltrim(line));
    // Cut off any '//' that is found
    line = string_rtrim_comment(line);
	
	if (read_state == STATE_FIND_SOUNDSCAPE)
	{
		// We read line by line, looking for some actual info
        if (string_length(line) == 0) continue;
		
		// Save the name
		read_soundscape_name = line;
		
		// Go to the next object state
		read_state = STATE_READ_BEGIN_SOUNDSCAPE;
	}
	if (read_state == STATE_READ_BEGIN_SOUNDSCAPE)
    {   // Look for opening bracket
	    if (string_pos("{", line) != 0)
	    {
	        // Create soundscape object (struct to-be)
			read_soundscape_instance = inew(_dummy);
			read_soundscape_instance.persistent = true;
			// Set default values;
			read_soundscape_instance.name = read_soundscape_name;
			read_soundscape_instance.fadetime  = 0.0;
			read_soundscape_instance.sounds = array_create(0);
			read_soundscape_instance.dsp = null;
		
	        // Go to read object state
	        read_state = STATE_READ_SOUNDSCAPE;
	        continue;
	    }
    }
	if (read_state == STATE_READ_SOUNDSCAPE)
	{
		// Object has ended - finalize it.
        if (string_pos("}", line) != 0)
        {
			// Finalize all the loading
			global.soundscape_lookup[?read_soundscape_name] = read_soundscape_instance;
			
			// Go to next object
			read_state = STATE_FIND_SOUNDSCAPE;
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
		// Fix if empty value
		if (string_length(key) == 0)
		{
			key = value;
			value = "";
		}
		
		// Now that we have the key-value, we perform parsing
		if (key == "fadetime")
		{
			read_soundscape_instance.fadetime = real(value);
		}
		else if (key == "playlooping" || key == "playrandom")
		{
			// Create soundinfo object (struct to-be)
			read_soundinfo_instance = inew(_dummy);
			read_soundinfo_instance.persistent = true;
			// Set defaults
			read_soundinfo_instance.type = (key == "playlooping") ? kSoundscapeSoundTypeLooping : kSoundscapeSoundTypeRandom;
			read_soundinfo_instance.volume_min = 1.0;
			read_soundinfo_instance.volume_max = 1.0;
			read_soundinfo_instance.pitch_min = 1.0;
			read_soundinfo_instance.pitch_max = 1.0;
			read_soundinfo_instance.time_min = 1.0;
			read_soundinfo_instance.time_max = 1.0;
			read_soundinfo_instance.attenuation = kSoundAttenuationDefault;
			read_soundinfo_instance.channel = kSoundChannelWorld;
			read_soundinfo_instance.position = kSoundscapeSoundPositionBase;
			read_soundinfo_instance.wavelist = array_create(0);
			
			// Go to read object state
	        read_state = STATE_READ_BEGIN_SOUNDINFO;
	        continue;
		}
		else if (key == "dsp")
		{
			// Create dsp object (struct to-be)
			read_dspinfo_instance = inew(_dummy);
			read_dspinfo_instance.persistent = true;
			
			// Set defaults:
			read_dspinfo_instance.type = 0;
			read_dspinfo_instance.volume = 1.0;
			read_dspinfo_instance.width = 100;
			
			// Go to read object state
	        read_state = STATE_READ_BEGIN_DSP;
	        continue;
		}
		else
		{	// Unrecognized key
			debugOut("Soundscape \"" + read_soundscape_instance.name + "\" had unrecognized key: \"" + string(key) + "\"");
		}
	}
	
	// Sound loading:
	if (read_state == STATE_READ_BEGIN_SOUNDINFO)
    {   // Look for opening bracket
	    if (string_pos("{", line) != 0)
	    {
			// Create map to load
			read_soundscape_soundinfo_map = ds_map_create();
		
	        // Go to read object state
	        read_state = STATE_READ_SOUNDINFO;
	        continue;
	    }
    }
	if (read_state == STATE_READ_SOUNDINFO)
    {
        // Object has ended - finalize it.
        if (string_pos("}", line) != 0)
        {
			// Load in all keys
			var volume = ds_map_find_value(read_soundscape_soundinfo_map, "volume");
			if (is_undefined(volume))
				volume = "1.0,1.0"
			var volume_list = string_split(volume, ", ", true);
			if (array_length_1d(volume_list) == 1)
				 volume_list[1] = volume_list[0];
			read_soundinfo_instance.volume_min = real(volume_list[0]);
			read_soundinfo_instance.volume_max = real(volume_list[1]);
			
			var pitch = ds_map_find_value(read_soundscape_soundinfo_map, "pitch");
			if (is_undefined(pitch))
				pitch = "1.0,1.0"
			var pitch_list = string_split(pitch, ", ", true);
			if (array_length_1d(pitch_list) == 1)
				 pitch_list[1] = pitch_list[0];
			read_soundinfo_instance.pitch_min = real(pitch_list[0]);
			read_soundinfo_instance.pitch_max = real(pitch_list[1]);
			
			var time = ds_map_find_value(read_soundscape_soundinfo_map, "time");
			if (is_undefined(time))
				time = "1.0,1.0"
			var time_list = string_split(time, ", ", true);
			if (array_length_1d(time_list) == 1)
				 time_list[1] = time_list[0];
			read_soundinfo_instance.time_min = real(time_list[0]);
			read_soundinfo_instance.time_max = real(time_list[1]);
			
			var attenuation = ds_map_find_value(read_soundscape_soundinfo_map, "attenuation")
			if (is_undefined(attenuation))
				attenuation = "default";
			if (attenuation == "default")
				read_soundinfo_instance.attenuation = kSoundAttenuationDefault;
			else if (attenuation == "speech")
				read_soundinfo_instance.attenuation = kSoundAttenuationSpeech;
			else
				read_soundinfo_instance.attenuation = real(attenuation);
				
			var channel = ds_map_find_value(read_soundscape_soundinfo_map, "channel")
			if (is_undefined(channel))
				channel = "world";
			if (channel == "world")
				read_soundinfo_instance.channel = kSoundChannelWorld;
			else if (channel == "music")
				read_soundinfo_instance.channel = kSoundChannelMusic;
			else if (channel == "speech")
				read_soundinfo_instance.channel = kSoundChannelSpeech;
			else if (channel == "key")
				read_soundinfo_instance.channel = kSoundChannelKey;
				
			var position = ds_map_find_value(read_soundscape_soundinfo_map, "position")
			if (is_undefined(position))
				position = "0";
			if (position == "random")
				read_soundinfo_instance.position = kSoundscapeSoundPositionRandom;
			else if (position == "random far")
				read_soundinfo_instance.position = kSoundscapeSoundPositionRandomFar;
			else if (position == "random near")
				read_soundinfo_instance.position = kSoundscapeSoundPositionRandomNear;
			else
				read_soundinfo_instance.position = real(position);
				
			var wave = ds_map_find_value(read_soundscape_soundinfo_map, "wave");
			if (!is_undefined(wave))
			{
				wave = string_replace_all(wave, "\"", "");
				wave = string_replace_all(wave, "'", "");
				read_soundinfo_instance.wavelist[0] = wave;
			}
				
			// Done with map
			ds_map_destroy(read_soundscape_soundinfo_map);
			
			// Save the new instance now that it's real
			read_soundscape_instance.sounds[array_length_1d(read_soundscape_instance.sounds)] = read_soundinfo_instance;
			
			// Go back up an object
			read_state = STATE_READ_SOUNDSCAPE;
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
		// Fix if empty value
		if (string_length(key) == 0)
		{
			key = value;
			value = "";
		}
		
		// Do specific key types
		if (key == "rndwave")
		{
			read_state = STATE_READ_BEGIN_WAVLIST;
			continue;
		}
		
		// Skip saving empty keys
		if (string_length(key) <= 0) continue;
		
        // Add the values to the ds_map
        if (!ds_map_add(read_soundscape_soundinfo_map, key, value))
        {
            debugOut("Soundscape \"" + read_soundscape_instance.name + "\" had duplicate keys: \"" + string(key) + "\"");
        }
	}
	// Soundlist loading:
	if (read_state == STATE_READ_BEGIN_WAVLIST)
    {   // Look for opening bracket
	    if (string_pos("{", line) != 0)
	    {
	        // Go to read object state
	        read_state = STATE_READ_WAVLIST;
	        continue;
	    }
    }
	if (read_state == STATE_READ_WAVLIST)
    {
        // Object has ended - finalize it.
        if (string_pos("}", line) != 0)
        {
			// Go back up an object
			read_state = STATE_READ_SOUNDINFO;
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
		if (string_length(key) <= 0) continue;
		
		// Do specific key types
		if (key == "wave")
		{	// Save the wave
			var wave = value;
			if (!is_undefined(wave))
			{
				wave = string_replace_all(wave, "\"", "");
				wave = string_replace_all(wave, "'", "");
				read_soundinfo_instance.wavelist[array_length_1d(read_soundinfo_instance.wavelist)] = wave;
			}
		}
		else
		{	// Unrecognized key
			debugOut("Soundscape \"" + read_soundscape_instance.name + "\" had unrecognized key: \"" + string(key) + "\" in rndwave structure.");
		}
	}
	
	// DSP loading:
	if (read_state == STATE_READ_BEGIN_DSP)
    {   // Look for opening bracket
	    if (string_pos("{", line) != 0)
	    {
			// Create map to load
			read_soundscape_dspinfo_map = ds_map_create();
		
	        // Go to read object state
	        read_state = STATE_READ_DSP;
	        continue;
	    }
    }
	if (read_state == STATE_READ_DSP)
    {
        // Object has ended - finalize it.
        if (string_pos("}", line) != 0)
        {
			var type = ds_map_find_value(read_soundscape_dspinfo_map, "id");
			if (is_undefined(type))
				read_dspinfo_instance.type = 0;
			else
				read_dspinfo_instance.type = type;
			
			var volume = ds_map_find_value(read_soundscape_dspinfo_map, "volume");
			if (!is_undefined(volume))
				read_dspinfo_instance.volume = real(volume);
			
			var width = ds_map_find_value(read_soundscape_dspinfo_map, "width");
			if (!is_undefined(width))
				read_dspinfo_instance.width = real(width);
			
			// Done with map
			ds_map_destroy(read_soundscape_dspinfo_map);
			
			// Save the new instance now that it's real
			read_soundscape_instance.dsp = read_dspinfo_instance;
			
			// Go back up an object
			read_state = STATE_READ_SOUNDSCAPE;
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
		if (string_length(key) <= 0) continue;
		
        // Add the values to the ds_map
        if (!ds_map_add(read_soundscape_dspinfo_map, key, value))
        {
            debugOut("Soundscape \"" + read_soundscape_instance.name + "\" had duplicate keys in dsp section: \"" + string(key) + "\"");
        }
	}
	
}