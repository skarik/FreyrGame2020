var target_x = argument0;
var target_y = argument1;

// Update target
if (abs(target_x - m_aipath_targetX) > 3 || abs(target_y - m_aipath_targetY) > 3 || room != m_aipath_targetRoom)
{
	if (room != m_aipath_targetRoom)
	{
		m_aipath_listing = null;
	}
	
	m_aipath_targetX = target_x;
	m_aipath_targetY = target_y;
	m_aipath_targetRoom = room;
	// Need a repath since the target changed.
	m_aipath_newpath = true;
}

// Get the best target to the next point
var next_x = target_x;
var next_y = target_y;

if (m_aipath_listing == null || m_aipath_current >= array_length_1d(m_aipath_listing))
{	// The target is just...the target. Straight shot.
	next_x = target_x;
	next_y = target_y;
	
	// Provide a mechanism to repath if failed to make a path
	if (m_aipath_listing == null)
	{
		m_aipath_repathtime += Time.deltaTime;
		if (m_aipath_failtime > 2.0) {
			m_aipath_newpath = true; // Request a repath every 2 seconds
		}
	}
}
else
{
	// If the path point exists, we want to get onto it.
	if (exists(m_aipath_listing[m_aipath_current]))
	{
		var next_dir = point_direction(x, y, m_aipath_listing[m_aipath_current].x, m_aipath_listing[m_aipath_current].y);
		next_x = m_aipath_listing[m_aipath_current].x + lengthdir_x(4, next_dir);
		next_y = m_aipath_listing[m_aipath_current].y + lengthdir_y(4, next_dir);
		// We need to increment to the next position
		if (point_distance(next_x, next_y, x, y) < 5 + m_aipath_failtime)
		{
			m_aipath_current += 1;
			m_aipath_failtime = 0.0;
		}
		else
		{
			m_aipath_failtime += 5.0 * Time.deltaTime;
		}
	}
	else
	{	// If there was an error in the path, we kill the path.
		m_aipath_listing = null;
		m_aipath_newpath = true;
	}
}

var dx = next_x - x;
var dy = next_y - y;
var ddist = point_distance(0, 0, dx, dy);
var dspeed = point_distance(0, 0, xspeed, yspeed);

// TODO:
// find the closest node if the target has changed
// check if the target is closer (and visible) or if the node is closer
// find a path
// reset the node status target shit

if (m_aipath_newpath)
{
	// Find the closest node (weighted towards the target)
	var closestNodeStart = ainodesGetClosest(x, y, z, true);
	var closestNodeEnd = ainodesGetClosest(target_x, target_y, 1024, true);
	
	// Check if the target or the start is closer
	if (exists(closestNodeStart))
	{
		if (ainodesCanPath(x, y, z, target_x, target_y))
		{
			if ((sqr(x - closestNodeStart.x) + sqr(y - closestNodeStart.y)) > (sqr(x - target_x) + sqr(y - target_y)))
			{
				m_aipath_listing = null;
				closestNodeStart = null;
				closestNodeEnd = null;
			}
		}
	}
	
	// We want to create a new path:
	aipathCreatePath(closestNodeStart, closestNodeEnd);
	
	// We no longer need a new path
	m_aipath_newpath = false;
	m_aipath_repathtime = 0.0;
	
	if (m_aipath_listing != null)
	{
		m_aipath_current = 0; // Start at the beginning of the path.
		m_aipath_failtime = 0.0;
		
		// With the new path, skip forward in the path with any nodes we can see
		while (m_aipath_current < array_length_1d(m_aipath_listing) &&
			ainodesCanPath(x, y, z, m_aipath_listing[m_aipath_current].x, m_aipath_listing[m_aipath_current].y))
		{
			m_aipath_current += 1;
		}
		// Then go back one
		m_aipath_current -= 1;
		// Clamp the path
		m_aipath_current = max(0, m_aipath_current);
	}
}

// Update the control structs
if (ddist > 10)
{	// Move to the target
	//_controlStructUpdate(xAxis, clamp(dx / max(kMoveSpeed * 0.9, ddist - 10), -1.0, +1.0));
	_controlStructUpdate(xAxis, clamp(dx / max(dspeed, ddist - 10), -1.0, +1.0));
	//_controlStructUpdate(yAxis, clamp(dy / max(kMoveSpeed * 0.9, ddist - 10), -1.0, +1.0));
	_controlStructUpdate(yAxis, clamp(dy / max(dspeed, ddist - 10), -1.0, +1.0));
}
else
{	// Close enough, we can stop
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
}