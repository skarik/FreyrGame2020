/// @description set volumes

var pl = getPlayer();

m_fadeSpeed = 2.0;

// Zero out all volumes first:
for (var i = 0; i < array_length_1d(m_tracks); ++i)
{
	m_trackVolume[i] = 0.0;
}

// Query the current state
var isClimaxing = (pl.moScriptOverride == _playerMotionCounterWait)
	|| (pl.moScriptOverride == _playerMotionCounterSeekHit)
	|| (pl.moScriptOverride == _playerMoAttackCounterHit);
var isEnemyAngry = false;
with (o_chGobboTest)
{
	if (m_aiCombat_angry)
	{
		isEnemyAngry = true;
		break;
	}
}
var isNearbyEnemy = false;
var isNearbyHeavy = false;
with (o_chGobboTest)
{
	if (!m_isDead && !m_isKOed && point_on_camera(x, y))
	{
		isNearbyEnemy = true;
		break;
	}
}
if (isNearbyEnemy)
{
	with (o_chGobboTest)
	{
		if (m_isHeavyFighter
			&& !m_isDead && !m_isKOed && point_on_camera(x, y))
		{
			isNearbyHeavy = true;
			break;
		}
	}
}

// update climax states
if (m_excitementLevel > 0)
{
	m_excitementTimer -= Time.deltaTime * (m_doCombatCooldown ? min(1.0, m_excitementLevel * 0.5) : 1.0);
	if (m_excitementTimer <= 0.0)
	{
		// Decrease music excitement levels over time during fights, but with long increments.
		m_excitementTimer = isEnemyAngry ? 16.0 : 2.0;
		m_excitementLevel -= 1;
		
		// Disable combat cooldown if on bottom level
		if (m_excitementLevel <= 0)
		{
			m_doCombatCooldown = false;
		}
	}
}
if (isNearbyEnemy)
{	// Force a bare minimum of the combat state when attacking
	m_excitementLevel = max(1, m_excitementLevel);
	// Do not count down the excitement below 1.
	if (m_excitementLevel <= 1)
	{
		m_excitementTimer = 2.0;
	}
	// If near heavy, do not count down the excitement below 2.
	if (isNearbyHeavy && m_excitementLevel <= 2)
	{
		m_excitementTimer = 2.0;
	}
}
if (isClimaxing && !m_wasClimaxing)
{
	m_wasClimaxing = isClimaxing;
	m_excitementLevel = min(4, m_excitementLevel + 1);
	m_excitementTimer = (isNearbyHeavy && m_excitementLevel < 4) ? 16.0 : 4.0;
}
// If angered an enemy, we probably want to enable combat volume down
if (isNearbyEnemy && isEnemyAngry)
{
	m_doCombatCooldown = true;
}

// update music based on what's going on
m_trackVolume[0] = 1.0; // Ambient
if (m_excitementLevel >= 1)
{
	m_trackVolume[0] = 0.0;
	m_trackVolume[1] = (!isEnemyAngry) ? 1.0 : 0.0;
	m_trackVolume[2] = isEnemyAngry ? 1.0 : 0.0;
}
if (isClimaxing || m_excitementLevel >= 2)
{
	m_trackVolume[0] = 0.0;
	m_trackVolume[1] = 0.0;
	m_trackVolume[2] = 0.0;
	if (m_excitementLevel == 2)
		m_trackVolume[3] = 1.0;
	else if (m_excitementLevel == 3)
		m_trackVolume[4] = 1.0;
	else if (m_excitementLevel >= 4)
		m_trackVolume[5] = 1.0;
}

// Clear out climax state
if (!isClimaxing && m_wasClimaxing)
{
	m_wasClimaxing = isClimaxing;
}

// Check for nearby world music tracks & duck as needed
var ducking = 0.0;
with (o_wmus_crescentTower)
{
	var pl_dist = point_distance(x, y, pl.x, pl.y);
	var gradient = saturate((pl_dist - m_sound.falloff_start) / (m_sound.falloff_end - m_sound.falloff_start));
	gradient = power(gradient, m_sound.falloff_factor * 2.0);
	ducking = max(ducking, 1.0 - gradient);
}

for (var i = 0; i < array_length_1d(m_tracks); ++i)
{
	m_trackVolume[i] *= 1.0 - ducking;
}

event_inherited();