if ( !input_fadeout )
{
    image_alpha += Time.dt * 3.0;
    if (image_alpha > 1) image_alpha = 1;
}
else
{
    image_alpha -= Time.dt * 3.0;
    if ( image_alpha <= 0.0 ) {
        delete(this);
        exit;
    }
}

if ( image_alpha > 0.5 )
{
    current_display_count += Time.dt * 60;
}

// If the done button showing?
if ( image_alpha >= 1.0 )
{
    controlUpdate(false);
    
    // Do selection changes
    if (!input_fadeout)
    {
        if ( yAxis.value > 0.8 && yAxis.previous < 0.8 )
        {
            display_choice += 1;
            gaudio_play_sound(snd_UiMenuChange, 50, false);
        }
        else if ( yAxis.value < -0.8 && yAxis.previous > -0.8 )
        {
            display_choice -= 1;
            gaudio_play_sound(snd_UiMenuChange, 50, false);
        }
    }
    display_choice = clamp(display_choice, 0, input_choice_count-1);
    
    // Do confirm selection
    if ( useButton.pressed )
    {
        if (!input_fadeout)
        {
            input_fadeout = true;
            gaudio_play_sound(snd_UiMsgBlip, 50, false);
        }
    }  
}
else
{
    controlUpdate(true);
}   

