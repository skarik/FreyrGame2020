/// @description Draw glowy bits

var xd = 120;
var yd = 70;

var eye_color = c_crystalblue;
eye_color = merge_color(c_crystalblue, c_gold, m_aiCombat_alerted ? saturate(m_aiCombat_aggroTimer * 3.0) : 0.0);

draw_set_color(merge_color(eye_color, c_black, 0.85));
draw_pie(x + xoffset - xd, y + yoffset - yd, x + xoffset + xd, y + yoffset + yd,
		 x + xoffset + lengthdir_x(xd, aimingDirection - m_aiCombat_noticeAngle),
		 y + yoffset + lengthdir_y(yd, aimingDirection - m_aiCombat_noticeAngle),
		 x + xoffset + lengthdir_x(xd, aimingDirection + m_aiCombat_noticeAngle),
		 y + yoffset + lengthdir_y(yd, aimingDirection + m_aiCombat_noticeAngle),
		 false);
		 
draw_set_color(merge_color(c_white, c_black, 0.95));
for (var i = 1; i < 4; ++i)
{
	draw_pie(x + xoffset - xd, y + yoffset - yd, x + xoffset + xd, y + yoffset + yd,
			 x + xoffset + lengthdir_x(xd, aimingDirection - m_aiCombat_noticeAngle + 90 * i),
			 y + yoffset + lengthdir_y(yd, aimingDirection - m_aiCombat_noticeAngle + 90 * i),
			 x + xoffset + lengthdir_x(xd, aimingDirection + m_aiCombat_noticeAngle + 90 * i),
			 y + yoffset + lengthdir_y(yd, aimingDirection + m_aiCombat_noticeAngle + 90 * i),
			 false);
}