/// @description Delayed init

m_collision = inew(ob_colliderNoDepth);
m_collision.x = x;
m_collision.y = y;
m_collision.image_xscale = image_xscale;
m_collision.image_yscale = image_yscale;
m_collision.image_angle = image_angle;
m_collision.sprite_index = sprite_index;

z = collision3_get_highest_position(x, y, z);


// create particle effects through the body
var divCount = floor(point_distance(bbox_left, bbox_top, bbox_right, bbox_bottom) / 24);
var sx, sy, ex, ey;
if (image_angle == 90 || image_angle == 270)
{
	sx = (bbox_left + bbox_right) / 2;
	ex = sx;
	sy = bbox_top;
	ey = bbox_bottom;
}
else
{
	sx = bbox_left;
	ex = bbox_right;
	sy = (bbox_top + bbox_bottom) / 2;
	ey = sy;
}
for (var i = 0; i <= divCount; ++i)
{
	var pct = (i / divCount) * 0.96 + 0.02;
	var tx = lerp(sx, ex, pct);
	var ty = lerp(sy, ey, pct);
			
	// Create dirt effect
	effectOnGroundHit(tx, ty);
}