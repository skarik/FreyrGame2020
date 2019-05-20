/// @description Draw the view

var draw_x = GameCamera.x;
var draw_y = GameCamera.y - (GameCamera.height * 0.5);
var draw_blend = m_timer;
if (m_fadeState == 1)
	draw_blend = 1.0;
else if (m_fadeState == 2)
	draw_blend = 1.0 - m_timer;

draw_y -= 45;
draw_y += 80 * ((m_fadeState != 2) ? bouncestep(draw_blend) : smoothstep(draw_blend));

var title_index = areaGetSubimage(m_area);

draw_sprite_ext(sui_areaTitles, title_index,
				draw_x - 1.0, draw_y, 1.0, 1.0, 0.0, c_black, 1.0);
draw_sprite_ext(sui_areaTitles, title_index,
				draw_x + 1.0, draw_y, 1.0, 1.0, 0.0, c_black, 1.0);
draw_sprite_ext(sui_areaTitles, title_index,
				draw_x, draw_y - 1.0, 1.0, 1.0, 0.0, c_black, 1.0);
draw_sprite_ext(sui_areaTitles, title_index,
				draw_x, draw_y + 1.0, 1.0, 1.0, 0.0, c_black, 1.0);

draw_sprite_ext(sui_areaTitles, title_index,
				draw_x, draw_y, 1.0, 1.0, 0.0, c_white, 1.0);
