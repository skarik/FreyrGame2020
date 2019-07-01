/// @description Screenshot 

var screenshot_requested = false;
if (keyboard_check_pressed(vk_f5))
{
	debugOut("screenshot requested");
	screenshot_requested = true;
}

if (screenshot_requested || (screenshot_auto_enabled && surface_exists(m_outputSurface)))
{
    screenshot_timer += Time.dt;
    // Take a screenshot every 1.0s
    if ( screenshot_timer > 1.0 || screenshot_requested )
    {
        screenshot_timer = 0;
        
        // Create screenshot dir
        //var dir = "./screenshots";
		var dir = "screenshots";
        if ( !directory_exists(dir) )
            directory_create(dir);
        // Ensure screenshots are not overridden
        while ( file_exists(dir + "/shot_" + string_replace_all(string_format(screenshot_count,4,0)," ","0") + ".png") )
            screenshot_count += 1;
            
        // Save the current screen
        var filename = "shot_" + string_replace_all(string_format(screenshot_count,4,0)," ","0") + ".png";
        //surface_save(m_outputSurface, working_directory + "/" + filename);
		surface_save(m_outputSurface, dir + "/" + filename);
        screenshot_count += 1;
		
		debugOut("screenshot " + string(screenshot_count) + " taken to " + filename);
    }
}

