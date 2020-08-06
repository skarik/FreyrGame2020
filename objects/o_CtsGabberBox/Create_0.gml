/// @description Gabberbox : For In-world
event_inherited();

#macro kUiDepthGabber (kUiDepthHudBase - 5)
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
input_minimal = false;

display_text = "";
display_flags[0] = null;
display_font = global.font_arvo9;
display_font_bold = global.font_arvo9Bold;
display_font_height = 9;
display_font_widths[0] = 0;
display_font_bold_widths[0] = 0;
display_width = 150;
display_blackbox_override = false;
display_whitebox_override = false;

display_height_old = 0.0;
display_height_blend = 1.0;

current_display_count = 0;
current_display_delay = 0;
current_display_time = 0;

current_display_letterShake = false;

image_alpha = 0;
done_alpha = 0;

controlInit();

// Set up UI for first frame
uiPosX = 0;
uiPosY = 0;

// Post-setup check
alarm[0] = 1;