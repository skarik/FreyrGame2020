with ( ob_CtsTalker )
{
    input_fadeout = true;
}

depth = -9005;

input_actor = null;
input_name = "";
input_text = "";
input_sprite = null;//suitPaladinTest;
input_fadeout = false;
input_priority = true;
input_disable = false;
input_audio = null;
input_autoclose = false;

display_text = "";
display_flags[0] = 0;
display_font = global.font_arvo9;
display_font_bold = global.font_arvo9Bold;
display_font_height = 9;
display_font_widths[0] = 0;
display_font_bold_widths[0] = 0;
display_width = 150;

current_display_count = 0;
current_display_delay = 0;
current_display_time = 0;

image_alpha = 0;
done_alpha = 0;

controlInit();

uiPosX = 0;
uiPosY = 0;