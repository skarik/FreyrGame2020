// update input
controlUpdate(false);

// Move the player
playerMotionStep();

// update camera
var aimerDistance = min(48.0,
						point_distance(o_PlayerTest.x, o_PlayerTest.y,
									   o_PlayerTest.uPosition, o_PlayerTest.vPosition)
						);
// fuck the aimer for now:
aimerDistance = 2.0;

var pl = id;
with (camera)
{
	camPlayerUpdate(
		round(round(pl.x) + lengthdir_x(aimerDistance, pl.aimingDirection)),
		round(round(pl.y) + lengthdir_y(aimerDistance, pl.aimingDirection) - pl.z_height),
		pl.xspeed,
		pl.yspeed);
}
view_update_audio();


// HACK: apply certain cutscene commands
if (m_aiScript_requestCommand == kAiRequestCommand_Teleport)
{
	m_aiScript_requestCommand = null;
	x = m_aiScript_requestPositionX;
	y = m_aiScript_requestPositionY;
	z_ready = false;
}
else if (m_aiScript_requestCommand == kAiRequestCommand_Face)
{
	m_aiScript_requestCommand = null;
	aimotionFaceAt(m_aiScript_requestPositionX, m_aiScript_requestPositionY, -1);
}
else if (m_aiScript_requestCommand == kAiRequestCommand_Animation)
{
	m_aiScript_requestCommand = null;
	
	var sprite_target = null;
	if (m_aiScript_requestAnimation == "wakeup0")
	{
		sprite_target = sc_16x16char;
	}
	else if (m_aiScript_requestAnimation == "wakeup1")
	{
		sprite_target = sc_16x16char;
	}
	else if (m_aiScript_requestAnimation == "sleepSnore")
	{
		sprite_target = s_charHeroSleepSnore;
	}
	
	if (sprite_target != null)
	{
		moAnimationPlayback = true;
		moAnimationPlaybackLooped = m_aiScript_requestAnimationLoop;
		moAnimationPlaybackEndOnFinish = false;
		animationSpeed = m_aiScript_requestSpeed;
		sprite_index = sprite_target;
	}
	else
	{
		moAnimationPlayback = false;
	}
}

// do hidden code
isHidden = false;
if (position_meeting(x, y, ob_areaTallGrass)
	&& position_meeting(x - 7, y, ob_areaTallGrass) && position_meeting(x + 7, y, ob_areaTallGrass)
	&& position_meeting(x, y - 4, ob_areaTallGrass) && position_meeting(x, y + 4, ob_areaTallGrass))
{
	isHidden = true;
}

// do lantern code
var have_lantern_belt = false;
for (var i = 0; i < inventory.belt_size; ++i)
{
	if (inventory.belt[i].object == o_pickupTool_Lantern)
	{
		have_lantern_belt = true;
	}
}
if (have_lantern_belt)
{
	if (!exists(m_lanternProp))
	{
		m_lanternProp = new(_dummy);
		m_lanternProp.sprite_index = s_itemToolLantern_Carried;
		m_lanternProp.visible = true;
		
		m_lanternLight = new(o_lightCrystalMothLanternGlow);
		m_lanternLight.image_alpha = 0.0;
	}
	
	m_lanternProp.x = x + lengthdir_x(6, round(facingDirection / 90) * 90 + 180);
	m_lanternProp.y = y + lengthdir_y(3, round(facingDirection / 90) * 90 + 180) - 10 - z_height;
	m_lanternProp.z = z;
	m_lanternProp.z_height = z_height + 10;
	m_lanternProp.depth = depth - round(lengthdir_y(4, facingDirection + 180)) + 1;
	
	m_lanternLight.x = m_lanternProp.x;
	m_lanternLight.y = m_lanternProp.y;// - m_lanternProp.z_height;
	m_lanternLight.image_alpha = min(1.0, m_lanternLight.image_alpha + Time.deltaTime);
}
else
{
	if (exists(m_lanternProp))
	{
		delete(m_lanternProp);
		m_lanternProp = null;
		
		delete(m_lanternLight);
	}
}

// do deathtar code!
if (areaInDeathtar(x, y, z))
{
	m_tarDeathTimer += Time.deltaTime;
	
	// Apply tar screen effects
	stats.m_healthPrev += 2;
	m_lastDamage = kDamageTypeTar;
	
	// If in tar for a full second...
	if (m_tarDeathTimer > 1.0)
	{
		m_tarDeathTimer = 0.0;
		
		var nearestSpawn = instance_nearest(x, y, ob_deathtarRespawnPoint);
		if (exists(nearestSpawn))
		{
			worldEventCreate(kWorldEvent_DeathtarGlitch);
		
			x = nearestSpawn.x;
			y = nearestSpawn.y;
		
			// deal damage & stun player
			var damage = clamp(stats.m_health - 5.0, 0.0, 2.0);
			if (stats.m_health <= 7.0)
			{
				damage += 2.0;
				stats.m_health += 2.0;
				stats.m_healthPrev = stats.m_health;
			}
			damageTargetForced(id, damage, kDamageTypeTar, true, false);
			m_stunTimer = max(m_stunTimer, 0.5);
		
			dungeonRoomReset();
		
			// Make camera locked on current position
			with (camera)
			{
				m_lockStrengthFader = 1.0; 
				m_lockX = GameCamera.x;
				m_lockY = GameCamera.y;
			}
		}
	
		playerMotionStop();
	}
}
else
{
	m_tarDeathTimer = 0.0;
}