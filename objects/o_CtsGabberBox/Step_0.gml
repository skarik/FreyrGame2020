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
		var cts = new2(o_CtsTimeExpand);
			cts.input_priority = this.input_priority; 
		
        delete(this);
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
        if ( display_flags[ceil(i)] == ord("p") )
            current_display_delay = 0.5; // Wait for half a second
		if ( display_flags[ceil(i)] == ord("k") )
			current_display_letterShake = true;
		if ( display_flags[ceil(i)] == ord("$") )
		{
			current_display_letterShake = false;
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
    if ( bButton.pressed )
    {
        if (!input_fadeout)
        {
            input_fadeout = true;
            audio_play_sound(snd_UiMsgBlip, 50, false);
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
        //input_fadeout = true;
    }
}
if ( input_autoclose )
{
    if ( current_display_count >= string_length(display_text) - 2 &&
         current_display_time > max(0.5, string_length(display_text) / 50) )
    {
        //input_fadeout = true;
    }
}