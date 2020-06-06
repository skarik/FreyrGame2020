/// @description All chest behavior

// Inherit the parent event
event_inherited();

// Run animation when opening:
var animationIndexPrev = animationIndex;
if (m_isKOed)
{
	animationIndex += Time.deltaTime * 15.0;
}
animationIndex = min(image_number - 1.0, animationIndex);
image_index = animationIndex;

// Make sound
if (animationIndexPrev < 1.0 && animationIndex >= 1.0)
{
	var audio = sound_play_at(x, y, snd_ChestOpen0);
	audio.pitch = random_range(0.95, 1.2);
	audio.gain = random_range(0.7, 0.9) * 0.4;
	audio.falloff_start = 20;
	audio.falloff_end = 800;
	audio.falloff_factor = 1;
	audio.parent = id;
}
// Make more sound
if (animationIndexPrev < 1.0 && animationIndex >= 1.0)
{
	var audio = sound_play_at(x, y, snd_ChestOpen1);
	audio.pitch = 1.0;
	audio.gain = 0.8;
	audio.falloff_start = 20;
	audio.falloff_end = 800;
	audio.falloff_factor = 1;
	audio.parent = id;
}
// Run the object dispensing
var animationKeyPoint = image_number * 0.75;
if (animationIndexPrev < animationKeyPoint && animationIndex >= animationKeyPoint)
{
	// Show a ding
	for (var dangle = 0; dangle < 360; dangle += 40)
	{
		var particle = instance_create_depth(x, y - 16, depth - 1, o_ptcNeatLine);
			particle.mdirection = dangle;
			particle.mspeed *= 2.0;
			particle.mfriction *= 2.0;
			particle.length *= 1.0;
			particle.life *= 0.5;
	}
	
	// Dispense the object
	var item_amount = max(1, m_itemDropAmount);
	var halfAngle = min(90, (item_amount - 1) * 30);
	for (var i = 0; i < item_amount; ++i)
	{
		var angle = 2 * halfAngle * (i / item_amount) + 270 - halfAngle;
		var sped = random_range(140, 180);
		
		var item = instance_create_depth(x, y + 16, depth, m_itemDrop);
			item.z_height = 24;
			item.z = z;
			item.m_pickupSpeedX = lengthdir_x(sped, angle);
			item.m_pickupSpeedY = lengthdir_y(sped, angle);
	}
	
	// Make even more sound
	var audio = sound_play_at(x, y, snd_ChestOpen2);
	audio.pitch = random_range(0.90, 1.00);
	audio.gain = random_range(0.7, 0.9) * 0.9;
	audio.falloff_start = 20;
	audio.falloff_end = 800;
	audio.falloff_factor = 1;
	audio.parent = id;
}

// Override motion to keep it still
xstart = x;
ystart = y;
xspeed = 0.0;
yspeed = 0.0;