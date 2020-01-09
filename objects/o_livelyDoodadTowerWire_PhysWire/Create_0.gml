/// @description Call parent, set up physics

// Inherit the parent event
event_inherited();

m_startPoint = [x, y];
m_endPoint = [x, y];

if (exists(m_attachPointStart))
	m_startPoint = [m_attachPointStart.x, m_attachPointStart.y];
if (exists(m_attachPointEnd))
	m_endPoint = [m_attachPointEnd.x, m_attachPointEnd.y];

// Set up wire constants
kSegmentDistance = 16;
kSegmentSlack = 4;

// Create the wire positions
m_segmentCount = ceil(point_distance(m_startPoint[0], m_startPoint[1], m_endPoint[0], m_endPoint[1]) / (kSegmentDistance - kSegmentSlack));
m_segments = array_create(m_segmentCount);
m_segmentDeltas = array_create(m_segmentCount); // Deltas array, used for verlet physics

// Start out the points in direct line to the target attachment point.
for (var i = 0; i < m_segmentCount; ++i)
{
	var interp = i / (m_segmentCount - 1);
	var point = [lerp(m_startPoint[0], m_endPoint[0], interp) + random_range(-1, +1),
				 lerp(m_startPoint[1], m_endPoint[1], interp) + random_range(-1, +1)];
	m_segments[i] = point;
}