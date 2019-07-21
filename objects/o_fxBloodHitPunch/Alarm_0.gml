/// @description push the sizes

var tc_bloodred = make_color_rgb(60, 159, 156); //make_color_rgb(239, 172, 40); //merge_color(c_red, c_maroon, 0.6);

// Create general circle hit
var circle = instance_create_depth(x, y, depth - 20, o_ptcCircleHit);
	circle.image_blend = tc_bloodred;
	circle.growSpeed = 200 * (m_damage / 8.0);
	circle.slowAccel = circle.growSpeed * 3;
	
// Create the blood effect
var blud = instance_create_depth(x, y, depth - 21, o_ptcBloodFaderFast);
	blud.image_blend = tc_bloodred;
	blud.image_angle = exists(m_source) ? (point_direction(m_source.x, m_source.y, x, y) + random_range(-20, +20)) : choose(0, 90, 180, 270);
	blud.image_xscale = 0.7;
//var outline = instance_create_depth(x, y, 0, o_ptcOutliner);
	//outline.m_target = blud;

var bludb = instance_create_depth(x, y, depth - 21, o_ptcBloodFaderFast);
	bludb.image_blend = tc_bloodred;
	bludb.image_angle = exists(m_source) ? (point_direction(x, y, m_source.x, m_source.y) + random_range(-20, +20)) : choose(0, 90, 180, 270);
	bludb.x += lengthdir_x(8, bludb.image_angle);
	bludb.y += lengthdir_y(8, bludb.image_angle);
	bludb.image_xscale = 1.4 * (m_damage / 4.0);
	bludb.image_yscale = 0.4;
//var outlineb = instance_create_depth(x, y, 0, o_ptcOutliner);
	//outlineb.m_target = bludb;

// Create the blood on the sand
/*var splat = instance_create_depth(x, y + 6, depth + 10, o_ptcBloodSplatter);
	splat.image_blend = tc_bloodred;
	splat.image_angle = exists(m_source) ? (point_direction(x, y, m_source.x, m_source.y) + random_range(-10, +10)) : choose(0, 90, 180, 270);
	splat.image_angle = round(splat.image_angle / 22.5) * 22.5;
	splat.x += lengthdir_x(16, splat.image_angle);
	splat.y += lengthdir_y(16, splat.image_angle);*/


// Remove this
delete(this);