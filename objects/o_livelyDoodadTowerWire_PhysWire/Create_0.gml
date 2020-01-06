/// @description Call parent, set up physics

// Inherit the parent event
event_inherited();


m_startPoint = [x, y];
m_endPoint = [x, y];

if (exists(m_attachPointStart))
	m_startPoint = [m_attachPointStart.x, m_attachPointStart.y];
if (exists(m_attachPointEnd))
	m_endPoint = [m_attachPointEnd.x, m_attachPointEnd.y];
	
m_segmentCount = ceil(point_distance(m_startPoint[0], m_startPoint[1], m_endPoint[0], m_endPoint[1]) / 16);
m_segments = array_create(m_segmentCount);