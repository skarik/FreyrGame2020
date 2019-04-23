if (m_book_totalBlend <= 0.01) exit;

surface_reset_target();
surface_set_target(m_surface);

var dx, dy;
dx = ((Screen.width / Screen.pixelScale) - 300) / 2;
dy = round(((Screen.height / Screen.pixelScale) - 186) * 1.0 - 16.0);
dy += (1.0 - smoothstep(m_book_totalBlend)) * 240;

draw_sprite(sui_bookPages, 0, dx, dy);

draw_sprite(sui_bookElements, 0, dx + 40, dy + 4);
draw_sprite(sui_bookElements, 0, dx + 61, dy + 9);
draw_sprite(sui_bookElements, 0, dx + 82, dy + 7);

draw_sprite(sui_bookPages, 1, dx, dy);

draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_black);
draw_set_alpha(1.0);
draw_set_font(f_josefinSlab9);

draw_text(dx + 24, dy + 30, "I should make camp.");
draw_text(dx + 24, dy + 50, "Time for a journal entry.");
draw_text(dx + 24, dy + 70, "Options");
draw_text(dx + 24, dy + 90, "Quicksave and Quit");
