/// @description draw_text_spaced(x, y, text, padding, wrap_width)
/// @param x
/// @param y
/// @param text
/// @param padding
/// @param wrap_width
var dx = argument0;
var dy = argument1;
var dtext = argument2;
var dpadding = argument3;
var dwrapwidth = argument4;

var dalignment = draw_get_halign();
draw_set_halign(fa_left);

var l_renderString = dtext;
var l_renderStringLength = string_length(l_renderString);
var l_pixelWidth = string_width(l_renderString);
var l_pixelLetterPadding = dpadding;
var l_pixelWidthModded = l_pixelWidth + l_pixelLetterPadding * (l_renderStringLength - 1);
var l_pixelHalfWidthCenter = floor((l_pixelWidthModded + string_length("m")) * 0.5);
var l_pixelHeight = string_height("M");
var l_penX = 0;
var l_penY = 0;

if (dalignment == fa_left)
{
	for (var i = 1; i <= l_renderStringLength; ++i)
	{
		var l_character = string_char_at(l_renderString, i);
		draw_text(dx + l_penX, dy + l_penY, l_character);
		l_penX += ceil(string_width(l_character) + l_pixelLetterPadding);
		
		if (is_space(l_character))
		{
			if (l_penX > dwrapwidth) // TODO: wrap on words
			{
				l_penY += l_pixelHeight;
				l_penX = 0;
			}
		}
	}
}
else if (dalignment == fa_center)
{
	for (var i = 1; i <= l_renderStringLength; ++i)
	{
		var l_character = string_char_at(l_renderString, i);
		draw_text(dx - l_pixelHalfWidthCenter + l_penX, dy + l_penY, l_character);
		l_penX += ceil(string_width(l_character) + l_pixelLetterPadding);
	}
}
else if (dalignment == fa_right)
{
	for (var i = 1; i <= l_renderStringLength; ++i)
	{
		var l_character = string_char_at(l_renderString, i);
		draw_text(dx - l_pixelWidthModded + l_penX, dy + l_penY, l_character);
		l_penX += ceil(string_width(l_character) + l_pixelLetterPadding);
	}
}

draw_set_halign(dalignment);