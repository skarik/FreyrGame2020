
// go to bottom layer surface
surface_reset_target();
surface_set_target(m_surfaceLightweightBack);

var l_activeEnemyList = array_create(0);
// find each enemy on-screen
var pl = getPlayer();
with (ob_character)
{
	if ((pl.m_team & this.m_team) == 0)
	{
		if (point_on_camera(x, y))
		{
			l_activeEnemyList[array_length_1d(l_activeEnemyList)] = this;
		}
	}
}

var d_offset_x = -(GameCamera.x - GameCamera.width / 2);
var d_offset_y = -(GameCamera.y - GameCamera.height / 2);

var kHeartSize = 9.0;

var l_activeEnemyListSize = array_length_1d(l_activeEnemyList);
for (var i = 0; i < l_activeEnemyListSize; ++i)
{
	var t_enemy = l_activeEnemyList[i];
	
	// get max health to calculate number of hearts needed
	var t_numHearts = ceil(t_enemy.stats.m_healthMax / 8.0);
	var t_healthDiv = t_enemy.stats.m_healthMax / t_numHearts;
	
	// calculate the width of the hearts volume
	var t_wcount = ceil(max(27, abs(t_enemy.bbox_right - t_enemy.bbox_left)) / kHeartSize);
	
	// find imaginary starting point from the center to the left
	var t_xoffset = (t_wcount - 1) / 2.0 * (kHeartSize + 1);
	var t_yoffset = (kHeartSize + 1) * ceil(t_numHearts / t_wcount) + ((t_enemy.stats.m_stunMax > 0) ? 7 : 3);
	
	var t_heartPenX = 0.0;
	var t_heartPenY = 0.0;
	for (var iheart = 0; iheart < t_numHearts; ++iheart)
	{
		var l_baseHealth = t_enemy.stats.m_health - t_healthDiv * iheart;
		var l_imageIndex = floor(4.99 * (1.0 - saturate(l_baseHealth / t_healthDiv)));
		
		// Draw heart
		draw_sprite(sui_heartMeter, l_imageIndex,
					t_enemy.x + d_offset_x - t_xoffset + t_heartPenX,
					t_enemy.y - t_enemy.sprite_yoffset - t_yoffset + d_offset_y + t_heartPenY);
		
		// Advance pen
		t_heartPenX += (kHeartSize + 1);
		if ((iheart % t_wcount) == (t_wcount - 1))
		{
			t_heartPenY += (kHeartSize + 1);
			t_heartPenX = 0.0;
		}
	}
	
	// draw the stun bar below the health
	if (t_enemy.stats.m_stunMax > 0)
	{
		var t_stunPercent = saturate(t_enemy.stats.m_stun / t_enemy.stats.m_stunMax);
		
		draw_set_alpha(0.25);
		draw_set_color(c_black);
		draw_rectangle(t_enemy.x + d_offset_x - t_xoffset,
					   t_enemy.y + d_offset_y - t_yoffset + 4,
					   t_enemy.x + d_offset_x + t_xoffset,
					   t_enemy.y + d_offset_y - t_yoffset + 6,
					   false);
					   
		draw_set_alpha(1.0);
		draw_set_color(c_gold);
		draw_rectangle(t_enemy.x + d_offset_x - t_xoffset,
					   t_enemy.y + d_offset_y - t_yoffset + 4,
					   t_enemy.x + d_offset_x - t_xoffset + (t_xoffset * 2) * t_stunPercent,
					   t_enemy.y + d_offset_y - t_yoffset + 6,
					   false);
	}
}

// reset target to original one
surface_reset_target();
surface_set_target(m_surfaceLightweight);