// Fade in and out
if ( !input_fadeout )
{
	itemlight_alpha += Time.dt * 1.0;
	if (itemlight_alpha > 1.6) // Center after lighting up
		itemcenter_alpha += Time.dt * 1.0;
	
	if (itemcenter_alpha > 1.0) // Fade in after the item is done doing its nonsense
		image_alpha += Time.dt * 1.0;
    if (image_alpha > 1) image_alpha = 1;
}
else
{
    image_alpha -= Time.dt * 3.0;
    if ( image_alpha <= 0.0 )
	{
		var cts = inew(o_CtsTimeExpand);
			cts.input_priority = this.input_priority; 
		
		event_user(6);
		
        idelete(this);
        exit;
    }
}

// Blend the height
display_height_blend += Time.deltaTime * 4.0;

// Count time textbox was on screen
current_display_time += Time.dt;

// Step through string and display the name characters
if ( current_display_delay <= 0.0 )
{
	var display_speed = 5;
	
	var previous_display_count = current_name_count;
	if ( image_alpha > 0.85 )
	{
		current_name_count += Time.dt * display_speed;
	}
	
	// Limit the count
	current_name_count = min( string_length(input_name), current_name_count );
	var index = floor(current_name_count);
	
	// We went to a new character?
    for (var i = previous_display_count; i < index; ++i)
    {
		// Yes, do character based updates
		//if (current_display_letterShake)
		//{
		if (!is_space(string_char_at(input_name, i + 1)))
		{
			effectScreenShake(3.0, 0.05, false);
			faudio_play_sound(snd_TypeHit, 10, false);
		}
    }
}

// Step through string and display characters
if ( current_display_delay <= 0.0 )
{
	var display_speed = 60;
	if (current_display_letterShake)
		display_speed *= 0.3;
	
    var previous_display_count = current_display_count;
    if ( current_name_count >= string_length(input_name)
		&& image_alpha > 0.85 )
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
			for (var iFlag = 0; iFlag < array_length_1d(flags); ++iFlag)
			{
		        if ( flags[iFlag] == ord("p") )
		            current_display_delay = 0.5; // Wait for half a second
				if ( flags[iFlag] == ord("k") )
					current_display_letterShake = true;
				if ( flags[iFlag] == ord("$") )
				{
					current_display_letterShake = false;
				}
			}
		}
		
		// Yes, do character based updates
		if (current_display_letterShake)
		{
			effectScreenShake(1.0, 0.05, false);
		}
    }
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
else
{
    controlUpdate(true);
}   

// Fade automatically over time if the option is given
if ( input_disable || !input_priority )
{
    if ( current_display_time > max(1.0, string_length(display_text) / 15) )
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

// Apply effect triggers
if (!itemtrigger_neat_effect && itemcenter_alpha > 1.0)
{
	itemtrigger_neat_effect = true;
	for (var dangle = 0; dangle < 360; dangle += 40)
	{
		var particle = instance_create_depth(uiPosX + display_width / 2 - 1, uiPosY - 16, depth + 1, o_ptcNeatLine);
			particle.mdirection = dangle;
			particle.mspeed *= 2.0;
			particle.mfriction *= 2.0;
	}
}
if (!itemtrigger_neat_effect2 && image_alpha >= 1.0)
{
	itemtrigger_neat_effect2 = true;
	for (var dangle = 0; dangle < 360; dangle += 60)
	{
		var particle = instance_create_depth(uiPosX + display_width / 2 - 1, uiPosY + display_height / 2, depth - 1, o_ptcNeatLine);
			particle.mdirection = dangle;
			particle.mspeed *= 1.0;
			particle.mfriction *= 2.0;
			particle.length *= 0.5;
			particle.life *= 0.5;
	}
}
if (image_alpha >= 0.0)
{
	itemtrigger_shine_time += Time.deltaTime;
}