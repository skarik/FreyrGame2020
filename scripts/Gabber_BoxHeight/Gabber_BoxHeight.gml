var kMarginLine = 5;
var kLineLeeway = 1.6;

return ceil( display_font_height*0.5 + (display_font_height + kMarginLine) * ceil(kLineLeeway * (string_width(display_text) + 1) / display_width) );