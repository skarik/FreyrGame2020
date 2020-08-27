/// @description Fade away

if (m_fadeOut)
{
	m_currentHeight -= Time.deltaTime * 64;
	
	if (m_currentHeight <= 0.0)
	{
		// create particle effects through the body
		var divCount = floor(point_distance(bbox_left, bbox_top, bbox_right, bbox_bottom) / 16);
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
		
		// delete the collider
		idelete(this);
		exit;
	}
}
else
{
	m_currentHeight = min(16, m_currentHeight + Time.deltaTime * 101);
}

depthUpdate();