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
	if (playerSeesHazard(kHazardRoboVoidShot))
	{
		var dd = beamAtkRanges;
		var dw = beamAtkWidth;
		var volumeAngle = beamAtkAngleOff;
	
		draw_set_color(c_white);
		draw_set_alpha(1.0);
		
		/*for (var i = 0; i < 3; ++i)
		{
			draw_quad(xoffset + x + lengthdir_x(dw, aimingDirection - 90) + lengthdir_x(dd[i], aimingDirection - volumeAngle),
					  yoffset + y + lengthdir_y(dw, aimingDirection - 90) + lengthdir_y(dd[i], aimingDirection - volumeAngle),
					  xoffset + x + lengthdir_x(dw, aimingDirection - 90) + lengthdir_x(dd[i+1], aimingDirection - volumeAngle),
					  yoffset + y + lengthdir_y(dw, aimingDirection - 90) + lengthdir_y(dd[i+1], aimingDirection - volumeAngle),
					  xoffset + x + lengthdir_x(dw, aimingDirection + 90) + lengthdir_x(dd[i], aimingDirection + volumeAngle),
					  yoffset + y + lengthdir_y(dw, aimingDirection + 90) + lengthdir_y(dd[i], aimingDirection + volumeAngle),
					  xoffset + x + lengthdir_x(dw, aimingDirection + 90) + lengthdir_x(dd[i+1], aimingDirection + volumeAngle),
					  yoffset + y + lengthdir_y(dw, aimingDirection + 90) + lengthdir_y(dd[i+1], aimingDirection + volumeAngle),
					  true);
		}*/

		var l_total_alpha = saturate((meleeAtkTimer / meleeAtk0Key) * 4.0);
		l_total_alpha *= saturate((1.1 - meleeAtkTimer / meleeAtk0Key) * 3.0);
		
		if (l_total_alpha > 0.0)
		{
			var px = xoffset + x;
			var py = yoffset + y;
			var vertex_info;
			var vertex;

			// draw the damage sectors
			for (var i = 0; i < 4; ++i)
			{
				vertex = array_create(4);
				vertex[0] = px + lengthdir_x(dw, aimingDirection - 90) + lengthdir_x(dd[i], aimingDirection - volumeAngle);
				vertex[1] = py + lengthdir_y(dw, aimingDirection - 90) + lengthdir_y(dd[i], aimingDirection - volumeAngle);
				vertex[2] = c_white;
				vertex[3] = 0.0;
				vertex_info[i * 3 + 0] = vertex;
			
				vertex = array_create(4);
				vertex[0] = px + lengthdir_x(dd[i], aimingDirection);
				vertex[1] = py + lengthdir_y(dd[i], aimingDirection);
				vertex[2] = c_white;
				vertex[3] = saturate(i + 0.2) * saturate(3.0 - i) * (0.3 + 0.1 * sin(Time.time * (1.7 + i * 0.5) + i)) * l_total_alpha;
				vertex_info[i * 3 + 1] = vertex;
			
				vertex = array_create(4);
				vertex[0] = px + lengthdir_x(dw, aimingDirection + 90) + lengthdir_x(dd[i], aimingDirection + volumeAngle);
				vertex[1] = py + lengthdir_y(dw, aimingDirection + 90) + lengthdir_y(dd[i], aimingDirection + volumeAngle);
				vertex[2] = c_white;
				vertex[3] = 0.0;
				vertex_info[i * 3 + 2] = vertex;
			}
			shader_set(sh_magiSightPrims);
			draw_primitive_begin(pr_trianglelist);
			for (var i = 0; i < 3; ++i)
			{
				vertex = vertex_info[(i + 0) * 3 + 0];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 1) * 3 + 0];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 0) * 3 + 1];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
			
				vertex = vertex_info[(i + 1) * 3 + 0];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 1) * 3 + 1];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 0) * 3 + 1];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
			
				vertex = vertex_info[(i + 0) * 3 + 2];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 1) * 3 + 2];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 0) * 3 + 1];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
			
				vertex = vertex_info[(i + 1) * 3 + 2];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 1) * 3 + 1];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
				vertex = vertex_info[(i + 0) * 3 + 1];
				draw_vertex_color(vertex[0], vertex[1], vertex[2], vertex[3]);
			}
			draw_primitive_end();
			shader_reset();
		
			// On top of it, draw the warning UI
			draw_set_alpha(l_total_alpha);
			draw_set_color(c_uigold);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_font(global.font_arvo9);
			draw_text_spaced(px + lengthdir_x(0.5 * (dd[1] + dd[2]), aimingDirection),
								py + lengthdir_y(0.5 * (dd[1] + dd[2]), aimingDirection),
								"-!-", 4);
		}
						 
		draw_set_alpha(1.0);
	}
	
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