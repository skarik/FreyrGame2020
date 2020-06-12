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
	|| (pl.moScriptOverride == _playerAttack_CounterHit);
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
with (o_chGobboTest)
{
	if (!m_isDead && !m_isKOed && point_on_camera(x, y))
	{
		isNearbyEnemy = true;
		break;
	}
}

// update climax states
if (m_excitementLevel > 0)
{
	m_excitementTimer -= Time.deltaTime;
	if (m_excitementTimer <= 0.0)
	{
		m_excitementTimer = 2.0;
		m_excitementLevel -= 1;
	}
}
if (isNearbyEnemy)
{	// Force a bare minimum of the combat state when attacking
	m_excitementLevel = max(1, m_excitementLevel);
	m_excitementTimer = 2.0;
}
if (isClimaxing && !m_wasClimaxing)
{
	m_wasClimaxing = isClimaxing;
	m_excitementLevel = min(3, m_excitementLevel + 1);
	m_excitementTimer = 3.0;
}

// update music based on what's going on
m_trackVolume[0] = 1.0; // Ambient
if (m_excitementLevel >= 1)
{
	m_trackVolume[0] = 0.0;
	m_trackVolume[1] = 1.0;
	m_trackVolume[2] = isEnemyAngry ? 1.0 : 0.0;
}
if (isClimaxing || m_excitementLevel >= 2)
{
	m_trackVolume[0] = 0.0;
	m_trackVolume[1] = 0.0;
	m_trackVolume[2] = 0.0;
	m_trackVolume[3] = 1.0;
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