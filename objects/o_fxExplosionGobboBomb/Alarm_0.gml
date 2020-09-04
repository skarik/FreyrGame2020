/// @description Create effect

var circle = instance_create_depth(x, y, depth - 100, o_ptcCircleHit_Outline);
	circle.fadeSpeed = 3;
	circle.image_blend = merge_color(c_gold, c_orange, 0.7);

repeat (14)
{
	var len = random(16);
	var dir = random(360);
	var smoke = instance_create_depth(x, y, depth - 102, o_ptcSmokeFlash);
		smoke.x += lengthdir_x(len, dir);
		smoke.y += lengthdir_y(len, dir);
		smoke.xspeed += lengthdir_x(len * 10, dir);
		smoke.yspeed += lengthdir_y(len * 10, dir);
}

repeat (5)
{
	var len = 8 + random(16);
	var dir = random(360);
	var stone = instance_create_depth(x, y, depth - 101, o_ptcFlamingPebble);
		stone.xspeed = lengthdir_x(len * 4, dir);
		stone.yspeed = lengthdir_y(len * 4, dir);
		stone.zspeed = random_range(50, 200);
}

repeat (2)
{
	var flame = instance_create_depth(x, y, depth - 101, o_ptcFlameGround);
		flame.x += random_range(-9, 9);
		flame.y += random_range(-5, 5);
}

var explo = instance_create_depth(x, y, depth - 104, o_ptcExplosion2);
	explo.image_xscale = choose(1, -1);

var dynalight = instance_create_depth(x, y, depth - 5, o_lightAllglowFader);
	dynalight.m_radius = 200.0;
	dynalight.m_radiusShrinkSpeed = 100.0;
	dynalight.m_colorFadeSpeed = 2.0;
	dynalight.image_blend = merge_color(c_gold, merge_color(c_red, c_white, 0.5), 0.5);
	
var dynalight2 = instance_create_depth(x, y, depth - 5, o_lightAllglowFader);
	dynalight2.m_radius = 100.0;
	dynalight2.m_radiusShrinkSpeed = 0.0;
	dynalight2.m_colorFadeSpeed = 4.0;
	dynalight2.image_blend = c_gold;

var sound_hit = sound_play_at(x, y, "audio/phys/explo6.wav");
	sound_hit.pitch = random_range(0.95, 1.1) * 1.6;
	sound_hit.gain = 1.0;
	sound_hit.falloff_start = 70;
	sound_hit.falloff_end = 1000;
	sound_hit.falloff_factor = 1;

idelete(this);