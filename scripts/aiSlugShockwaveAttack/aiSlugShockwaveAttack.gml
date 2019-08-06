// Create a ripple effect
var circle = instance_create_depth(x, y, depth + 1, o_ptcCircleHit);
	circle.image_blend = c_crystalblue;
	circle.growSpeed = 60;
	circle.slowAccel = circle.growSpeed * 1.5;
	circle.fadeSpeed = 1.5;
	
var circle = instance_create_depth(x, y, depth + 1, o_ptcCircleHit);
	circle.image_blend = c_crystalblue;
	circle.growSpeed = 200;
	circle.slowAccel = circle.growSpeed * 3.0;
	circle.fadeSpeed = 1.5;
	
// damage radius is 16*2.5

var count = instance_number(ob_character);
for (var i = 0; i < count; ++i)
{
	var target = instance_find(ob_character, i);
	
	if (damageCanHit(id, target))
	{
		if (point_distance(x, y, target.x, target.y) < 16 * 2.5)
		{
			damageTarget(target, 1.0, kDamageTypeAcid, true, true);
			target.m_stunTimer += 0.5;
		}
	}
}