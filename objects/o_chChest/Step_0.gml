/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Run animation when opening:
var animationIndexPrev = animationIndex;
if (m_isDead)
{
	animationIndex += Time.deltaTime * 15.0;
}
animationIndex = min(image_number - 1.0, animationIndex);
image_index = animationIndex;

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
	repeat (max(1, m_itemDropAmount))
	{
		var item = instance_create_depth(x, y + 4, depth, m_itemDrop);
			item.z_height = 16;
	}
}

// Override motion to keep it still
xstart = x;
ystart = y;
xspeed = 0.0;
yspeed = 0.0;