/// @description Choose sprite & setup

event_inherited();

sprite_index = choose(s_propTBowl1, s_propTBowl1, s_propTBowl2, s_propTBowl3);
image_index = 1;
image_speed = 0.0;

xspeed = 0.0;
yspeed = 0.0;

bbox = [sprite_get_bbox_left(sprite_index),
		sprite_get_bbox_right(sprite_index),
		sprite_get_bbox_top(sprite_index),
		sprite_get_bbox_bottom(sprite_index)];
radius = sqrt(sqr(bbox[0] - bbox[1]) + sqr(bbox[2] - bbox[3])) * 0.5;


if (!exists(o_managerWaterBowlMovement))
	new(o_managerWaterBowlMovement);