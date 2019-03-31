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
    cts_entry_current++;
    cts_execute_state = 0;
    break;

case SEQTYPE_WAIT:
    if (cts_execute_state == 0)
    {   // Go to timer state
        cts_execute_state = 1;
        cts_execute_timer = 0;
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
        
        var target_inst = instance_find(target, count);
    
        // Make a talker with all the input info
        var gabber = Cts_MakeGabber(target_inst, "", line);
            gabber.input_priority = !cts_organic;
            gabber.input_disable = cts_organic;
            gabber.input_autoclose = (ending == SEQEND_AUTO);
            
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
            if (facing == -1 || facing == 1)
            {
                target_inst.facingDir = facing;
            }
            else if (exists(facing))
            {
                target_inst.facingDir = sign(facing.x - target_inst.x);
            }
        }
        
        // On the next step
        cts_execute_state = 1;
    }
    // No longer exists? We go to the enxt entry.
    else if (!exists(o_CtsTalkerBox) && !exists(o_CtsGabberBox))
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
        
        var gabber = new(o_CtsChoiceBox);
            gabber.input_choice_count = count;
            for (var i = 0; i < count; ++i)
            {
                gabber.input_choice[i] = ds_map_find_value(entry, i+1);
            }
        // On the next step
        cts_execute_state = 1;
        return false;
    }
    // No longer exists? We go to the enxt entry.
    else if (!exists(o_CtsChoiceBox))
    {
        cts_entry_current++;
        cts_execute_state = 0;   
    }
    else
    {
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
		else
		{
			cts_execute_state = 1;
		}
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
				delete_delay(o_fxFadeOutBanded, 0);
				cts_entry_current++;
			    cts_execute_state = 0;   
			}
		}
		else
		{
			cts_entry_current++;
			cts_execute_state = 0;   
		}
	}
	break;
}

return true;

