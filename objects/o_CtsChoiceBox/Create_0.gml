event_inherited();

with ( ob_CtsTalker )
{
    input_fadeout = true;
}

depth = kUiDepthGabber;

input_actor = null;
input_choice_count = 0;
input_choice[0] = "Nothing";
input_fadeout = false;
input_priority = true;

display_font = global.font_arvo9;
display_font_height = 9;
display_width = 150;
display_choice = 0;
display_blackbox_override = false;
display_whitebox_override = false;

current_display_count = 0;

image_alpha = 0;

controlInit();

// Set up UI for first frame
uiPosX = 0;
uiPosY = 0;