/// @description Perform wire physics if in view

// Inherit the parent event (update lighting)
event_inherited();

// Update the constant positions in the wire
if (exists(m_attachPointStart))
	m_startPoint = [m_attachPointStart.x, m_attachPointStart.y];
if (exists(m_attachPointEnd))
	m_endPoint = [m_attachPointEnd.x, m_attachPointEnd.y];
	
// Set up the restaining points
m_segments[0] = m_startPoint;
m_segments[m_segmentCount - 1] = m_endPoint;

// 
// Work on the cheapo verlet physics

// Perform distance limits to each connection
var kDistanceLimitRelaxer = 0.9;
for (var i = 1; i < m_segmentCount - 1; ++i)
{
	var delta = [0, 0];
	
	var pointCenter = m_segments[i];
	var pointPrev = m_segments[i - 1];
	var pointNext = m_segments[i + 1];
	var pointDelta;
	var distSqr;
	var dist;
	var factor;
	
	// Add restraint toward previous point
	pointDelta = [pointPrev[0] - pointCenter[0], pointPrev[1] - pointCenter[1]];
	distSqr = sqr(pointDelta[0]) + sqr(pointDelta[1]);
	if (distSqr > sqr(kSegmentDistance))
	{
		dist = sqrt(distSqr);
		factor = (1.0 / dist) * max(0.0, dist - kSegmentDistance) * 0.5 * kDistanceLimitRelaxer;
		delta[0] += pointDelta[0] * factor;
		delta[1] += pointDelta[1] * factor;
	}
	
	// Add restraint towards next point
	pointDelta = [pointNext[0] - pointCenter[0], pointNext[1] - pointCenter[1]];
	distSqr = sqr(pointDelta[0]) + sqr(pointDelta[1]);
	if (distSqr > sqr(kSegmentDistance))
	{
		dist = sqrt(distSqr);
		factor = (1.0 / dist) * max(0.0, dist - kSegmentDistance) * 0.5 * kDistanceLimitRelaxer;
		delta[0] += pointDelta[0] * factor;
		delta[1] += pointDelta[1] * factor;
	}
	
	// Save new delta back
	m_segmentDeltas[i] = delta;
}

// Apply the verlet results
for (var i = 1; i < m_segmentCount - 1; ++i)
{
	var point = m_segments[i];
	var delta = m_segmentDeltas[i];
	
	point[0] += delta[0];
	point[1] += delta[1];
	
	m_segments[i] = point;
}