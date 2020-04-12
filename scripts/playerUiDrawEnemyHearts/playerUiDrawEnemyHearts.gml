
// go to bottom layer surface
surface_reset_target();
surface_set_target(m_surfaceLightweightBack);

var l_enemyMapCount = ds_map_size(m_enemyActiveMap);
var l_currentEnemy = ds_map_find_first(m_enemyActiveMap);
for (var i = 0; i < l_enemyMapCount; ++i)
{
	var timers = m_enemyActiveMap[?l_currentEnemy];
	
	// Update the timers
	timers[0] -= Time.deltaTime;
	timers[1] -= Time.deltaTime;
	// Update the heart startus
	if (exists(l_currentEnemy))
	{
		timers[2] = motion1d_to(timers[2], l_currentEnemy.stats.m_health, Time.deltaTime * 48.0);
		timers[3] = motion1d_to(timers[3], l_currentEnemy.stats.m_stun, Time.deltaTime * 8.0);
	}
	// Save back the status
	m_enemyActiveMap[?l_currentEnemy] = timers;
	
	// Go to next enemy
	var l_previousEnemy = l_currentEnemy;
	l_currentEnemy = ds_map_find_next(m_enemyActiveMap, l_currentEnemy);
	
	// Remove previous key if it falls past the check
	if (!exists(l_previousEnemy) || (timers[0] < 0 && timers[1] < 0))
	{
		ds_map_delete(m_enemyActiveMap, l_previousEnemy);
	}
}
 
//var l_activeEnemyList = array_create(0);
// find each enemy on-screen
var pl = getPlayer();
with (ob_character)
{
	if ( (this.m_uiwantsHealthShown || this.m_uiwantsStaminaShown)
		&& ((pl.m_team & this.m_team) == 0) )
	{
		if (point_on_camera(x, y))
		{
			//l_activeEnemyList[array_length_1d(l_activeEnemyList)] = this;
			
			var timers;
			if (ds_map_exists(other.m_enemyActiveMap, this))
			{
				timers = other.m_enemyActiveMap[?this];
				timers[0] = max(timers[0], this.m_uiwantsHealthShown ? 1.0 : 0.0);
				timers[1] = max(timers[1], this.m_uiwantsStaminaShown ? 1.0 : 0.0);
			}
			else
			{
				timers = [this.m_uiwantsHealthShown ? 1.0 : 0.0, this.m_uiwantsStaminaShown ? 1.0 : 0.0, 0, this.stats.m_stunMax];
			}
			other.m_enemyActiveMap[?this] = timers;
		}
	}
}

//m_enemyHealthList

var d_offset_x = -(GameCamera.x - GameCamera.width / 2);
var d_offset_y = -(GameCamera.y - GameCamera.height / 2);

var kHeartSize = 9.0;
var kStimmSize = 7.0;

var l_activeEnemyListSize = ds_map_size(m_enemyActiveMap);//array_length_1d(l_activeEnemyList);
var t_enemy = ds_map_find_first(m_enemyActiveMap);
for (var i = 0; i < l_activeEnemyListSize; ++i)
{
	//var t_enemy = l_activeEnemyList[i];
	var timers = m_enemyActiveMap[?t_enemy];
	if (!exists(t_enemy))
	{
		t_enemy = ds_map_find_next(m_enemyActiveMap, t_enemy);
		continue;
	}
	
	if (timers[0] > 0.0)
	{
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
			//var l_baseHealth = (ceil(t_enemy.stats.m_health * 4) / 4) - t_healthDiv * iheart;
			var l_baseHealth = (ceil(timers[2] * 4) / 4) - t_healthDiv * iheart;
			var l_imageIndex = floor(4.99 * (1.0 - saturate(l_baseHealth / t_healthDiv)));
		
			// Draw heart
			draw_sprite(sui_heartMeter, l_imageIndex,
						t_enemy.x + d_offset_x - t_xoffset + t_heartPenX,
						t_enemy.y - t_enemy.m_standingHeight - t_yoffset + d_offset_y + t_heartPenY);
		
			// Advance pen
			t_heartPenX += (kHeartSize + 1);
			if ((iheart % t_wcount) == (t_wcount - 1))
			{
				t_heartPenY += (kHeartSize + 1);
				t_heartPenX = 0.0;
			}
		}
	}
	
	// draw the stun bar below the health
	//if (t_enemy.m_uiwantsStaminaShown && t_enemy.stats.m_stunMax > 0)
	if (timers[1] > 0.0 && t_enemy.stats.m_stunMax > 0)
	{
		// get max stun to calculate number of bips needed
		var t_numStuns = min(8, ceil(t_enemy.stats.m_stunMax));
		var t_stunDiv = t_enemy.stats.m_stunMax / t_numStuns;
		
		// calculate the width of the stun volume
		var t_wcount = t_numStuns;
		
		// draw 1 bip per stamina point, centered above.
		// inverse, so empty the stamina bips as stun is increased
		
		// find imaginary starting point to the left
		var t_xoffset = (t_wcount - 1) / 2.0 * (kStimmSize + 1);
		var t_yoffset = (kHeartSize + 1) + 3;
		
		var t_stimmPenX = 0.0;
		var t_stimmPenY = 0.0;
		//var t_effectiveDisplayStimm = t_enemy.m_isStunned ? t_enemy.stats.m_stunMax : t_enemy.stats.m_stun;
		var t_effectiveDisplayStimm = t_enemy.m_isStunned ? t_enemy.stats.m_stunMax : timers[3];
		t_effectiveDisplayStimm = ceil((t_enemy.stats.m_stunMax - t_effectiveDisplayStimm) * 4) / 4;
		for (var istimm = 0; istimm < t_numStuns; ++istimm)
		{
			var l_baseStun = t_effectiveDisplayStimm - t_stunDiv * istimm;
			var l_imageIndex = floor(4.99 * (1.0 - saturate(l_baseStun / t_stunDiv)));
		
			// Draw bip
			draw_sprite(sui_stunMeter, l_imageIndex,
						t_enemy.x + d_offset_x - t_xoffset + t_stimmPenX,
						t_enemy.y - t_enemy.m_standingHeight - t_yoffset + d_offset_y + t_stimmPenY);
		
			// Advance pen
			t_stimmPenX += (kStimmSize + 1);
			/*if ((istimm % t_wcount) == (t_wcount - 1))
			{
				t_stimmPenY += (kStimmSize + 1);
				t_stimmPenX = 0.0;
			}*/
		}
		
		//var t_stunPercent = saturate(t_enemy.stats.m_stun / t_enemy.stats.m_stunMax);
		//draw_set_alpha(0.25);
		//draw_set_color(c_black);
		//draw_rectangle(t_enemy.x + d_offset_x - t_xoffset,
		//			   t_enemy.y + d_offset_y - t_yoffset + 4,
		//			   t_enemy.x + d_offset_x + t_xoffset,
		//			   t_enemy.y + d_offset_y - t_yoffset + 6,
		//			   false);
		//			   
		//draw_set_alpha(1.0);
		//draw_set_color(c_gold);
		//draw_rectangle(t_enemy.x + d_offset_x - t_xoffset,
		//			   t_enemy.y + d_offset_y - t_yoffset + 4,
		//			   t_enemy.x + d_offset_x - t_xoffset + (t_xoffset * 2) * t_stunPercent,
		//			   t_enemy.y + d_offset_y - t_yoffset + 6,
		//			   false);
	}
	
	t_enemy = ds_map_find_next(m_enemyActiveMap, t_enemy);
}

// reset target to original one
surface_reset_target();
surface_set_target(m_surfaceLightweight);