/// @description draw the text

draw_set_font(f_04b03);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var kString = "PRESS ANYTHING";
//var kStringWidth = string_width(kString);
var kStringLength = string_length(kString);

draw_set_color(c_white);


var characterDiv = 10;
for (var i = 0; i < kStringLength; ++i)
{
	var character = string_char_at(kString, i + 1);
	var x_position = x - (kStringLength - 1) / 2.0 * characterDiv + i * characterDiv;
	
	if (!fade) {
		draw_set_alpha(saturate(image_alpha * (kStringLength+2) * 0.3 - i * 0.3));
	}
	else {
		var index = kStringLength - i - 1;
		draw_set_alpha(saturate(image_alpha * (kStringLength+2) * 0.3 - index * 0.3));
	}
	draw_text(x_position, y, character);
}

draw_set_alpha(1.0);