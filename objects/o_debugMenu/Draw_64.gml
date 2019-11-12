gpu_set_blendmode(bm_normal);
draw_set_alpha(image_alpha);
draw_set_color(c_white);
draw_set_halign( fa_left );
draw_set_valign( fa_bottom );

draw_set_font(f_04b03);

// Draw helper 
draw_set_halign( fa_left );
draw_set_valign( fa_top );
draw_text( 10,10, "Press tilde (`) to toggle this menu.");

// draw more helpers
draw_text( 10, 24, "(F5) Screenshot");
draw_text( 10, 32, "(F11) Capture GIF");
draw_text( 10, 40, "(F3) Frame limiter");

// Draw the debug info
draw_set_color( c_black );
draw_set_alpha(image_alpha * 0.5);
for (var i = 0; i < Debug.debug_line_count; ++i)
{
	var dx = 60;
	var dy = 720-60 - (Debug.debug_line_count-i)*10;
	draw_rectangle(dx - 1, dy - 1, dx + string_width(Debug.debug_line[i]), dy + string_height("Mg"), false);
}

draw_set_alpha(image_alpha);
draw_set_color( c_electricity );
draw_set_halign( fa_left );
draw_set_valign( fa_top );
for (var i = 0; i < Debug.debug_line_count; ++i)
{
    draw_text( 60, 720-60 - (Debug.debug_line_count-i)*10, Debug.debug_line[i] );
}

// Draw the mouse position
draw_set_color( c_white );
draw_arrow( uiMouseX+16, uiMouseY+16, uiMouseX, uiMouseY, 16 );

draw_set_alpha(1.0);

// draw the quest flags
questDebugDisplayFlags();