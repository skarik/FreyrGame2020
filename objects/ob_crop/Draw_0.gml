/// @description sprite & grow val
draw_self();

if (Debug.visible)
{
	draw_set_color(c_red);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(f_04b03);
	draw_text(x, y + 7, string(m_growValue));
}