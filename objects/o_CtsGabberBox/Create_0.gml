/// @description Gabberbox : For In-world
event_inherited();

#macro kUiDepthGabber (kUiDepthHudBase - 10)
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

display_font = global.font_arvo9;
display_font_bold = global.font_arvo9Bold;
display_font_height = 9;

display_font_mumble = global.font_arvo6;
display_font_mumble_bold = global.font_arvo6Bold;
display_font_mumble_height = 6;

display_font_minimal = global.font_arvo7;
display_font_minimal_bold = global.font_arvo7;
display_font_minimal_height = 7;

#region Apply Font Settings

// Gabber font settings
if (Settings.gameplay_ui_font_size == 9)
{
	display_font = global.font_arvo9;
	display_font_bold = global.font_arvo9Bold;
	display_font_height = 9;
	
	display_font_mumble = global.font_arvo6;
	display_font_mumble_bold = global.font_arvo6Bold;
	display_font_mumble_height = 6;
}
else if (Settings.gameplay_ui_font_size == 10)
{
	display_font = global.font_arvo10;
	display_font_bold = global.font_arvo10Bold;
	display_font_height = 10;
	
	display_font_mumble = global.font_arvo7;
	display_font_mumble_bold = global.font_arvo7;
	display_font_mumble_height = 7;
}
// Talker font settings
if (Settings.gameplay_ui_font_size_talk == 7)
{
	display_font_minimal = global.font_arvo7;
	display_font_minimal_bold = global.font_arvo7;
	display_font_minimal_height = 7;
}
else if (Settings.gameplay_ui_font_size_talk == 8)
{
	display_font_minimal = global.font_arvo8;
	display_font_minimal_bold = global.font_arvo8;
	display_font_minimal_height = 8;
}

#endregion

display_text = "";
display_flags[0] = null;
display_font_widths[0] = 0;
display_font_bold_widths[0] = 0;
display_width = 150;
display_blackbox_override = false;
display_whitebox_override = false;
display_thin_margins = false;

display_height_old = 0.0;
display_height_blend = 1.0;

display_tail_disabled = false;
display_tail_override = false;
display_tail_override_x = 0.0;
display_tail_override_y = 0.0;
display_tail_override_direction = SEQI_FACING_RIGHT;

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