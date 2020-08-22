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

idelete(this);