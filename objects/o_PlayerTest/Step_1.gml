/// @description On Hurt effects

// Create screen shake and other On-hurt effects
if ( m_isPlayer && stats.m_health < stats.m_healthPrev )
{
    var damage_gradient = (stats.m_healthPrev - stats.m_health) * (100 / stats.m_healthMax);
	if (m_lastDamage != kDamageTypeTar)
	{
	    effectScreenShake(
	        1 + floor(damage_gradient * 0.25),
	        0.3 + min(1.5, floor(damage_gradient) * 0.03),
	        true);
	}
    effectControllerShake(
        1.0,
        0.2 + floor(damage_gradient) * 0.03,
        true);
		
	var tc_bloodred = merge_color(c_red, c_maroon, 0.6);
	var tc_bloodgold = make_color_rgb(239, 172, 40);
		
	repeat (max(2.0, (stats.m_healthPrev - stats.m_health) * 0.2))
	{
		var blud = inew(o_ptcBloodHud);
			blud.m_damageType = m_lastDamage;
			// Set up colors
			blud.image_blend = tc_bloodred;
		// Make it gold when really hurt
		if (stats.m_health < stats.m_healthMax * 0.5) {
			if (random(1.0) > stats.m_health / stats.m_healthMax) {
				blud.image_blend = tc_bloodgold;
			}
		}
		with (blud) event_user(0); // Init the blood
	}
	// On Hurt for hud-blood
	with (o_ptcBloodHud) event_user(kEvent_ChOnHurt1);
	
	// Make hurt sound
	audio = sound_play_at(x, y, "audio/npc/hurt.wav");
	audio.pitch = random_range(0.7, 0.8);
	audio.gain = random_range(0.3, 0.4);
	audio.falloff_start = 30;
	audio.falloff_end = 300;
	audio.falloff_factor = 2;
	audio.parent = id;
	
	// Damage will
	if (m_will > 0)
	{
		m_will -= (stats.m_healthPrev - stats.m_health) * 15.0;
	}
	else
	{
		m_willpush -= ceil((stats.m_healthPrev - stats.m_health) / 5.0);
	}
}

if (keyboard_check(ord("G")))
	m_will -= Time.deltaTime * 100.0;
if (keyboard_check(ord("H")))
	m_willpush -= Time.deltaTime * 2.0;

//
// Mana logic:
m_mana -= Time.deltaTime * 10.0;
m_mana = clamp(m_mana, 0, m_manaMax);

//
// Will logic:

// decrease at 1 per second
if (worldShouldTick())
{
	if (Debug.convention_mode)
		m_will -= Time.deltaTime * 3.0;
	else
	m_will -= Time.deltaTime;
}
// Limit will
m_will = min(m_willMax, m_will);

// If will hits zero, we're in willpush mode
if (m_will > 0)
{
	m_willpush = m_willpushMax;
}
else
{
	// do stuns only when not busy
	if (!isAttacking && !isDashing && !isBlocking && !m_isTilling && !m_isPlanting)
	{
		// stall regen when willpush is used
		if (m_willpush < m_willpushPrevious)
		{
			m_willpushRegenTimer = 0.0;
			// We actually out of stamina?
			if (m_willpush <= 0.0)
			{	// Then we perform a ministun.
				stats.m_stun = stats.m_stunMax + 1;
				m_willStyleStun = true;
			}
		}
		else
			m_willpushRegenTimer += Time.deltaTime;
	}
	else
	{
		m_willpushRegenTimer = 0.0;
	}
	
	// regen willpush after 2 seconds
	if (m_willpushRegenTimer > 2.0)
		m_willpush += Time.deltaTime * m_willpushMax; // Regen it all in 1 second
}
// Defer willpush updates until later
if (!isAttacking && !isDashing && !isBlocking && !m_isTilling && !m_isPlanting)
{
	m_willpush = clamp(m_willpush, 0, m_willpushMax);
	m_willpushPrevious = m_willpush;
}

//
// Stun logic:

// Force reset stun meter when taking a break for a while
if (m_stunTimer <= -3.0)
{
	stats.m_stun = max(0, stats.m_stun - Time.deltaTime);
}

// Stamina display logic:
m_uiwantsStaminaShown = false;
if (m_isStunned || m_stunTimer > 0.0 || stats.m_stun > 0.0)
{
	m_uiwantsStaminaShown = true;
}
else
{
	// Check if enemies have stun displayed
	with (ob_character)
	{
		if ( this.m_uiwantsStaminaShown && (other.m_team & this.m_team) == 0 )
		{
			other.m_uiwantsStaminaShown = true;
		}
	}
}

//
// Health and stun logic:
event_inherited();

