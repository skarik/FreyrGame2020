/// @description Draw tarot card labels

var dx = GameCamera.x;
var dy = GameCamera.y;

// Create a faded in background
draw_set_color(c_black);
draw_set_alpha(0.5 * m_state_blend_background);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1.0);

// Create the dealing prompt
if (m_state_blend_deal > 0.0 && m_state_blend_select < 1.0)
{
	draw_set_color(c_white);
	draw_set_font(global.font_arvo9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var spaced_string = "Select a card.";
	for (var i = 1; i <= string_length(spaced_string); ++i)
	{
		var char = string_char_at(spaced_string, i);
		var offset = (i - string_length(spaced_string) * 0.5) * 8;
		
		draw_set_alpha((1.0 - m_state_blend_select) * saturate(m_state_blend_deal * (string_length(spaced_string) + 1) - i));
		draw_text(dx + offset, dy - GameCamera.height * 0.5 + 64, char);
	}
	draw_set_alpha(1.0);
}

// Show the chosen card
if (m_state_blend_select > 0.0)
{
	draw_set_alpha(saturate(m_state_blend_select * 2.0 - 1.0));
	
	draw_set_color(c_white);
	draw_set_font(global.font_arvo9);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var spaced_string = m_card[m_state_selection].m_name;
	for (var i = 1; i <= string_length(spaced_string); ++i)
	{
		var char = string_char_at(spaced_string, i);
		var offset = (i - string_length(spaced_string) * 0.5) * 10;
		draw_text(dx + offset, dy - GameCamera.height * 0.5 + 40, char);
	}
	draw_set_alpha(1.0);
}
if (m_state_blend_select_continue > 0.0)
{
	draw_sprite_ext(sui_buttonPress3, 0,
					dx,
					dy + GameCamera.height * 0.5 - 40,
					bouncestep(m_state_blend_select_continue),
					bouncestep(m_state_blend_select_continue),
					0.0,
					c_white,
					1.0);
}