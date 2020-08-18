/// @description On KO (health < 0)

// Inherit the parent event
event_inherited();

dropItems(kDropSeparateChances,[
	[o_pickupCons_ScorpStick, 0.33, 1],
	[o_pickupCons_HoneyAbsinthe, 0.25, 1],
]);

// Can passthru when we die
isPassthru = true;

// Do KO velocity
if (iexists(m_tookDamageSource))
{
	var ldir = point_direction(x, y, m_tookDamageSource.x, m_tookDamageSource.y);
	var lspeed = random_range(160, 260);
	
	zspeed = (300 - lspeed) * 0.5;
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