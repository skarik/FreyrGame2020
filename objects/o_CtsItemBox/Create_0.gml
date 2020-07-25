event_inherited();

with ( ob_CtsTalker )
{
    input_fadeout = true;
}

depth = kUiDepthGabber;

input_actor = null;
input_name = "";
input_text = "";
input_sprite = null;//suitPaladinTest;
input_fadeout = false;
input_priority = true;
input_disable = false;
input_audio = null;
input_autoclose = false;
input_addItem = true;

display_text = "";
display_flags[0] = null;
display_font = global.font_arvo9;
display_font_bold = global.font_arvo9Bold;
display_font_height = 9;
display_font_widths[0] = 0;
display_font_bold_widths[0] = 0;
display_width = 180;
display_height = 120;

display_height_old = 0.0;
display_height_blend = 1.0;

display_item_startx = 0.0;
display_item_starty = 0.0;

current_display_count = 0;
current_display_delay = 0;
current_display_time = 0;

current_display_letterShake = false;

current_name_count = 0;
current_name_timedown = 0;

image_alpha = 0;
done_alpha = 0;

itemlight_alpha = 0;
itemcenter_alpha = 0;
itemtrigger_neat_effect = false;
itemtrigger_neat_effect2 = false;
itemtrigger_shine_time = 0;

controlInit();

// Set up UI for first frame
uiPosX = 0;
uiPosY = 0;

// Create the surfaces for the shine effect
surface_shine_bg = null;
surface_shine_item = null;

// Create light pass stuff
glower = inew(o_lightEmissiveDepth_User5);
glower.target = id;