/// @description Draw glowy bits

//if (live_call()) return live_result;

var xd = 120;
//var yd = 70;
var yd = 120;

var eye_color = c_crystalblue;
eye_color = merge_color(c_crystalblue, c_gold, m_aiCombat_alerted ? saturate(m_aiCombat_aggroTimer * 3.0) : 0.0);
eye_color = merge_color(eye_color, c_red, m_aiCombat_angry ? saturate(3.0 - m_aiCombat_deaggroTimer) : 0.0);

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

if (isAttacking)
{
	draw_set_color(c_crystallime);
			  
	// draw a glow as we warm our beam
	draw_set_alpha(saturate(meleeAtkTimer / meleeAtk0Key) * 0.2);
	draw_circle_color(x + xoffset, y + yoffset,
					  16 + saturate(meleeAtkTimer / meleeAtk0Key) * 48,
					  c_crystallime, c_black, false);
					  
	if (meleeAtkTimer < meleeAtk0Key)
	{	// draw the charge circle (for easier visual timing)
		draw_set_alpha(saturate(meleeAtkTimer / meleeAtk0Key) * 1.0);
		draw_circle(x + xoffset, y + yoffset - 5,
					5 + sqr(1.0 - saturate(meleeAtkTimer / meleeAtk0Key)) * 128,
					true);
	}
	
	draw_set_alpha(1.0);
}