/// @description Draw the cable

draw_set_color(c_black);
for (var i = 0; i < m_segmentCount - 1; ++i)
{
	var pointA = m_segments[i];
	var pointB = m_segments[i + 1];
	
	draw_line(pointA[0], pointA[1],
			  pointB[0], pointB[1] );
}

draw_set_color(c_white);
for (var i = 0; i < m_segmentCount - 1; ++i)
{
	var pointA = m_segments[i];
	var pointB = m_segments[i + 1];
	
	draw_line(pointA[0], pointA[1] - (pointA[2] - m_renderZreference),
			  pointB[0], pointB[1] - (pointB[2] - m_renderZreference) );
}