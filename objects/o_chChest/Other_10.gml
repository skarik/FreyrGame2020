/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

m_isDead = true;

for (var dangle = 0; dangle < 360; dangle += 60)
{
	var particle = instance_create_depth(x, y - 8, depth - 1, o_ptcNeatLine);
		particle.mdirection = dangle;
		particle.mspeed *= 2.0;
		particle.mfriction *= 2.0;
		particle.length *= 1.0;
		particle.life *= 0.5;
}