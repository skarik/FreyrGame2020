// Fade in and out
if ( !input_fadeout )
{
    image_alpha += Time.dt * 3.0;
    if (image_alpha > 1) image_alpha = 1;
}
else
{
    image_alpha -= Time.dt * 3.0;
    if ( image_alpha <= 0.0 )
	{
		var cts = inew(o_CtsTimeExpand);
			cts.input_priority = this.input_priority; 
			
        idelete(this);
        exit;
    }
}

// Blend the height
display_height_blend += Time.deltaTime * 4.0;

// Count time textbox was on screen
current_display_time += Time.dt;

// Step through string and display characters
if ( current_display_delay <= 0.0 )
{
	var display_speed = 60;
	if (current_display_letterShake)
		display_speed *= 0.3;
	
    var previous_display_count = current_display_count;
    if ( image_alpha > 0.5 )
    {
        current_display_count += Time.dt * display_speed;
    }
    
    // Limit the count
    current_display_count = min( string_length(display_text), current_display_count );
    var index = floor(current_display_count);
    
    // We went to a new character?
    for (var i = previous_display_count; i < index; ++i)
    {
        // Do character-based updates
		var flags = display_flags[ceil(i)];
		if (is_array(flags))
		{
			var flags_len = array_length_1d(flags);
			for (var iFlag = 0; iFlag < flags_len; ++iFlag)
			{
				var flag = flags[iFlag];
		        if ( flag == ord("p") )
		            current_display_delay = 0.5; // Wait for half a second
				if ( flag == ord("k") )
					current_display_letterShake = true;
				if ( flag == ord("$") )
				{
					current_display_letterShake = false;
				}
			}
		}
		
		// Yes, do character based updates
		if (current_display_letterShake)
		{
			effectScreenShake(2.0, 0.05, false);
		}
		
		// Play sound on a new character
		//if (floor(previous_display_count) < index)
		if ((floor(i) % 6) == 0 || current_display_delay > 0.0)
		{
			// Do audio playing
			var audio = faudio_play_sound(snd_MsgBepType, 51, false);
			faudio_sound_set_gain(audio, random_range(0.3, 0.4) * 0.5);
			faudio_sound_set_pitch(audio, choose(0.2, 0.2, 0.25, 0.25, 0.3) * 4.0);
		}
		
		// Stop outputting text if there's any sort of delay
		if (current_display_delay > 0.0)
		{
			break;
		}
    } // End for-loop (adding characters & parsing effects)
}
else
{
    current_display_delay -= Time.dt;
}

// Has the counter hit the end?
var l_can_end = false;
if (current_display_count >= string_length(display_text))
{
	l_can_end = true;
    done_alpha += Time.dt * 4.0;
    if (done_alpha > 1) done_alpha = 1;
}
else
{
	done_alpha -= Time.dt * 4.0;
	if (done_alpha < 0) done_alpha = 0;
}

// If the done button showing?
if ( done_alpha > 0.5 && l_can_end )
{
	if ( !input_disable && !input_minimal )
	{
	    controlUpdate(false);
	    if ( useButton.pressed )
	    {
	        if (!input_fadeout)
	        {
	            input_fadeout = true;
	            faudio_play_sound(snd_UiMsgBlip, 50, false);
	        }
	    }   
	}
}
else
{
    controlUpdate(true);
}   

// Fade automatically over time if the option is given
if ( input_disable || !input_priority )
{
    if ( current_display_time > max(1.0, 0.2 + string_length(display_text) / 8) )
    {
        input_fadeout = true;
    }
}
if ( input_autoclose )
{
    if ( current_display_count >= string_length(display_text) - 2 &&
         current_display_time > max(0.5, string_length(display_text) / 50) )
    {
        input_fadeout = true;
    }
}