if (singleton_this()) exit;

event_inherited();

// override chracter value
m_isPlayer = true;

m_team = kTeamGood;
m_name = "Cortez";
m_bloodType = kBloodRedWill;

m_currentArea = kAreaNoArea;
m_currentAreaTimer = 0.0;

controlInit();

playerMotionInit();
//playerAnimInit();
characterAnimInit();
playerInteractInit();

// create scriptable vars for cutscenes
aiScriptableInit();

camera = inew(o_PlayerCamera);
hud = inew(o_PlayerHud);
inventory = inew(o_inventory);
if (!iexists(o_PlayerQuest))
	quests = inew(o_PlayerQuest);
else
	quests = instance_find(o_PlayerQuest, 0);
if (!iexists(o_PlayerStats))
	pstats = inew(o_PlayerStats);
else
	pstats = instance_find(o_PlayerStats, 0);
// update name
m_name = pstats.m_name;

// make sure there's day/night
if (!iexists(o_dayNightCycle))
	inew(o_dayNightCycle);

m_prevInventoryActive = false;

m_lanternProp = null;
m_lanternLight = null;
m_lanternEmissive = null;

m_tarDeathTimer = 0.0;

m_will = 16 * 60;
m_willMax = m_will;
m_willPrevious = m_will;
m_willpush = 4;
m_willpushMax = m_willpush;
m_willpushPrevious = m_willpush;
m_willpushRegenTimer = 0.0;
m_willStyleStun = false;

m_mana = 0;
m_manaMax = 20;

m_itemBalancePivot = [x, y];
m_itemBalanceSpeed = [0, 0];
m_itemBalanceSpringOffset = [0, 0];
m_itemBalanceSpringOffsetPrevious = [0, 0];
m_itemBalanceSpringTimestep = 0.0;

m_perfectCounterTarget = null;
m_perfectCounterFreezer = null; // Freeze time object
m_perfectCounterFocuser = null; // Focus effect object
m_perfectCounterTimer = 0.0;

#region Effects
	// the player alright has a character-light, but for no-ambient rooms, it gets disabled
	// thus, we need a specific light that shows the character location
	m_locatorLight = inew(o_lightEmissiveDepth_User5);
	m_locatorLight.target = id;
	m_locatorSh_uColorKey = shader_get_uniform(sh_colorkeyAlphatest, "uColorKey");
#endregion

#region Stats
	stats.m_health = 20.0;
	stats.m_healthMax = stats.m_health;
	stats.m_healthPrev = stats.m_health;
	stats.m_stunMax = 5.0;
#endregion

#region Checkpoint state
	playerCheckpointInit();
#endregion

#region Constants

kMoveSpeed = 120;
kMoveSpeedWaterPercent = 0.50;
kMoveSpeedBlockingPercent = 0.50;
kMoveSpeedCarryingPercent = 0.50;
kMoveSpeedDeathtarPercent = 0.25;
kMoveAcceleration = 800;
kMoveAccelerationStop = 500;
kMoveAccelerationAir = 200;
kMoveAccelerationAirStop = 10;
//kDashDistance = 48;
//kDashTime = 0.15; // movespeed of about 240
kDashDistance = 72;
kDashTime = 0.5;
kDashCooldown = 0.3;
kDashInAir = true;

#endregion

#region Sprites

kAnimStanding = s_charHeroStand;
kAnimWalking = s_charHeroWalk;
kAnimRunning = s_charHeroRun;
kAnimRolling = s_charHeroRoll;
kAnimSinkFalling = s_charHeroSinkFall;
kAnimAttack1 = s_charHeroAtk1;
kAnimDig1 = s_charHeroPunchDig;
kAnimHarvest1 = s_charHeroHarvestPlant0;
kAnimStun = s_charHeroStunned;

#endregion

#region Melee

/*
meleeAtk0Time = 0.2;
meleeAtk0Hit = 0.05;
meleeAtk0Key = 0.10;
meleeAtk0Script = _playerMoAttack0;
meleeAtk0Damage = 2;

meleeAtk1Time = 0.2;
meleeAtk1Hit = 0.05;
meleeAtk1Key = 0.10;
meleeAtk1Script = _playerMoAttack1;
meleeAtk1Damage = 2;

meleeAtk2Time = 0.5;
meleeAtk2Hit = 0.1;
meleeAtk2Key = 0.3;
meleeAtk2Script = _playerMoAttack2;
meleeAtk2Damage = 2;

meleeAtk3Time = 0.4;
meleeAtk3Hit = 0.2;
meleeAtk3Key = 0.21;
meleeAtk3Script = _playerMoAttack3;
meleeAtk3Damage = 5;
*/

meleeAtk0Time = 0.5;
meleeAtk0Hit = 1 / 8.0 * meleeAtk0Time;// 0.05;
meleeAtk0Key = 4 / 8.0 * meleeAtk0Time;//0.10;
meleeAtk0Script = _playerMoAttack0;
meleeAtk0Damage = 0.5;

meleeAtk1Time = 0.5;
meleeAtk1Hit = 1 / 8.0 * meleeAtk1Time;//0.05;
meleeAtk1Key = 4 / 8.0 * meleeAtk1Time;//0.10;
meleeAtk1Script = _playerMoAttack1;
meleeAtk1Damage = 0.5;

meleeAtk2Time = 0.9;
meleeAtk2Hit = 0.1;
meleeAtk2Key = 0.3;
meleeAtk2Script = _playerMoAttack2;
meleeAtk2Damage = 0.5;

meleeAtk3Time = 0.7;
meleeAtk3Hit = 0.2;
meleeAtk3Key = 0.21;
meleeAtk3Script = _playerMoAttack3;
meleeAtk3Damage = 1;

#endregion

#region Rendering setup

function depthWorldDraw_Player()
{
	var dx, dy;
	dx = round(x);
	dy = round(y);

	// Draw the player
	var kPlayerSurfaceSize = 64;
	var kPlayerSurfaceCenter = 32;
	var l_playerBuffer = surface_create(kPlayerSurfaceSize, kPlayerSurfaceSize);
	surface_set_target(l_playerBuffer);
	draw_clear_alpha(c_white, 0.0);
	{
		var ihead = pstats.m_head;
		var ibody = pstats.m_body;
		var igend = _gendToIndex(pstats.m_gender);
	
		if (sprite_index == s_heroSleepingH0)
		{
			var head = [s_heroSleepingH0, s_heroSleepingH1, s_heroSleepingH2];
			var gend = [s_heroSleepingG0, s_heroSleepingG1, s_heroSleepingG2];
			var bott = [s_heroSleepingB0, s_heroSleepingB1, s_heroSleepingB2];
			_drawChara(head[ihead], image_index, kPlayerSurfaceCenter);
			_drawChara(gend[igend], image_index, kPlayerSurfaceCenter);
			_drawChara(bott[ibody], image_index, kPlayerSurfaceCenter);
		}
		else if (sprite_index == s_charHeroStand)
		{
			var head = [s_heroStandH0, s_heroStandH1, s_heroStandH2];
			var body = [s_heroStandB0, s_heroStandB1, s_heroStandB2];
			_drawChara(head[ihead], image_index, kPlayerSurfaceCenter);
			_drawChara(body[ibody], image_index, kPlayerSurfaceCenter);
		}
		else
		{
			_drawChara(sprite_index, image_index, kPlayerSurfaceCenter);
		}
	}
	surface_reset_target();

	// Draw the actual composited player
	if ((!inWater && !inTar) || z_height > 1)
	{	
		// Draw normal depth, but with the moAnimationYOffset change vs depthDrawSelf().
		gpu_set_blendmode(bm_normal);
		gpu_set_alphatestenable(true);
		draw_surface(l_playerBuffer,
					 dx - kPlayerSurfaceCenter,
					 round(dy - z_height + moAnimationYOffset) - kPlayerSurfaceCenter);
	}
	else
	{	// Draw in-liquid
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
		draw_surface_part(l_playerBuffer,
						 0, 0,
						 kPlayerSurfaceSize,
						 kPlayerSurfaceCenter + 2 - 8,
						 dx - kPlayerSurfaceCenter,
						 round(dy - z_height + moAnimationYOffset) - kPlayerSurfaceCenter);
	}

	// Free up temp buffer used for player
	surface_free(l_playerBuffer);

	// Draw the held item
	if (inventory.belt_selection >= 0 && inventory.belt_selection < array_length_1d(inventory.belt))
	{
		var balance_delta = m_itemBalanceSpringOffset;
		var held_item = inventory.belt[inventory.belt_selection];
		if (held_item.onUse == generalYeetableOnUse
			&& held_item.object_index != o_pickupJunk_Rock)
		{
			var item_sprite = object_get_sprite(held_item.object);
			var balance_step_x = 0.23 * balance_delta[0] + 0.4 * (sin(Time.time) + sin(Time.time * 0.74));
			var balance_step_y = (8 - balance_delta[1] * 0.1) - sqr(abs(balance_step_x)) * 0.25;
			for (var i = 0; i < held_item.count; ++i)
			{
				draw_sprite(item_sprite, 0,
							dx + i * balance_step_x,
							dy - z_height - 26 - i * balance_step_y);
			}
		}
	}
}
function depthShadowDraw_Player()
{
	var dx, dy;
	dx = round(x);
	dy = round(y);

	// Draw the actual composited player
	if ((!inWater && !inTar) || z_height > 1)
	{	// Draw normal depth, but with the moAnimationYOffset change vs depthDrawSelf().
		var shadow_pct = max(0.75, sprite_height / 32.0);
		shadow_pct /= (1.0 + max(0.0, z_height) / 32.0);
		var shadow_w = shadow_pct * 6.0;
		var shadow_h = shadow_pct * 2.0;

		draw_sprite_ext(
			slt_shadow_24x8, 0,
			floor(dx), floor(dy),
			shadow_w / 12, shadow_h / 4,
			0.0,
			shadowSillohuetteColor(),
			image_alpha);
	}
}

depthSetWorldDrawFunction(depthWorldDraw_Player);
depthSetShadowDrawFunction(depthShadowDraw_Player);

#endregion