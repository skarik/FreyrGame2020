/// @description draw the shield

draw_set_color(image_blend);
draw_set_alpha(image_alpha);

draw_rectangle(x - width, y - 1024, x - 1024, y + 1024, false);
draw_rectangle(x + width, y - 1024, x + 1024, y + 1024, false);
draw_rectangle(x - width, y - height, x + width, y - 1024, false);
draw_rectangle(x - width, y + height, x + width, y + 1024, false);

draw_set_alpha(1.0);