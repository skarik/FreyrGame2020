/// @description Draw self w/ depth

//if (live_call()) return live_result;

var dx, dy;
dx = round(x);
dy = round(y);

//if (!inWater || z_height > 1)
{
	depthDrawSelf();
}
/*else
{
	gpu_set_alphatestenable(false);
	gpu_set_blendenable(true);
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_color(c_ltgray);
	draw_ellipse(dx - 7 - 2, dy - 2 - 4 - 1, dx + 6 + 2, dy + 2 - 4 + 1, false);

	gpu_set_blendmode_ext(bm_dest_color, bm_src_color);
	draw_set_color(c_white);
	draw_ellipse(dx - 7 + 1, dy - 2 - 4, dx + 6 - 1, dy + 2 - 4, false);

	gpu_set_blendmode(bm_normal);
	gpu_set_alphatestenable(true);
	draw_sprite_part(sprite_index, image_index,
					 0, 0,
					 sprite_get_width(sprite_index), sprite_get_height(sprite_index) - 8,
					 x - sprite_get_xoffset(sprite_index),
					 y - sprite_get_yoffset(sprite_index) + 4);
}*/

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
			var px = x;
			var py = y;
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
}