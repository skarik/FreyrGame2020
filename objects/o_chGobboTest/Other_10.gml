/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

dropItems(kDropSeparateChances,[
	[o_pickupCons_ScorpStick, 1 / 5, 1],
	[o_pickupCons_HoneyAbsinthe, 1 / 10, 1],
	[o_pickupJunk_Spork, .25, 1],
]);

// Stop anim override
moAnimationExternal = false;

// Can passthru when we die
isPassthru = true;

// Do KO velocity
if (iexists(m_tookDamageSource))
{
	var ldir = point_direction(m_tookDamageSource.x, m_tookDamageSource.y, x, y);
	var lspeed = random_range(70, 120);
	
	// Perform a "jump"
	onGround = false;
	z += 2;
	zspeed = (220 - lspeed) * 0.4;
	// Begin moving
	xspeed = lengthdir_x(lspeed, ldir);
	yspeed = lengthdir_y(lspeed, ldir);
}

// Do sound
sound = sound_play_at(x, y, snd_npcGobboKO);
sound.pitch = random_range(0.95, 1.1) * 0.8;
sound.gain = random_range(0.7, 0.9) * 0.5;
sound.falloff_start = 20;
sound.falloff_end = 800;
sound.falloff_factor = 1;
sound.parent = id;

// Override motion with death motion
moScriptOverride = _characterMoDeadSlide;