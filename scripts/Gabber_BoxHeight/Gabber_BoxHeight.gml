var kMarginTop = exists(input_actor) ? 10 : 0;
var kMarginLine = 5;
var kLineLeeway = 1.6;

return ceil( kMarginTop + display_font_height*0.5 + (display_font_height + kMarginLine) * ceil(kLineLeeway * (string_width(display_text) + 1) / display_width) );