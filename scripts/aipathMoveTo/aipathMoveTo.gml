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
{	
	// The target is just...the target. Straight shot.
	next_x = target_x;
	next_y = target_y;
	m_aipath_state_onLast = true;
	
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
	if (iexists(m_aipath_listing[m_aipath_current]))
	{
		var next_dir = point_direction(x, y, m_aipath_listing[m_aipath_current].x, m_aipath_listing[m_aipath_current].y);
		next_x = m_aipath_listing[m_aipath_current].x;// + lengthdir_x(4, next_dir);
		next_y = m_aipath_listing[m_aipath_current].y;// + lengthdir_y(4, next_dir);
		m_aipath_state_onLast = false;
		
		// We need to increment to the next position
		if (point_distance(next_x, next_y, x, y) < 5 + m_aipath_failtime)
		{
			m_aipath_current += 1;
			m_aipath_failtime = 0.0;
			
			m_aipath_state_shortcutCheckTime += 1.0; // Force a shortcut check immediately.
		}
		else
		{
			m_aipath_failtime += 5.0 * Time.deltaTime;
		}
		
		// We also want to check if the next point on the path is visible at any time. If so, we can cut corners.
		m_aipath_state_shortcutCheckTime += Time.deltaTime * 4.0;
		if (m_aipath_state_shortcutCheckTime >= 1.0)
		{
			var next_next_x = target_x;
			var next_next_y = target_y;
			if (m_aipath_current + 1 < array_length_1d(m_aipath_listing) && iexists(m_aipath_listing[m_aipath_current + 1]))
			{
				next_next_x = m_aipath_listing[m_aipath_current + 1].x;
				next_next_y = m_aipath_listing[m_aipath_current + 1].y;
			}
			var next_next_dir = point_direction(x, y, next_next_x, next_next_y);
			var next_next_ofx = lengthdir_x(2, next_next_dir + 90);
			var next_next_ofy = lengthdir_y(2, next_next_dir + 90);
			if (!collision3_line(x, y, next_next_x, next_next_y, z, false)
				&& !collision3_line(x + next_next_ofx, y + next_next_ofy, next_next_x + next_next_ofx, next_next_y + next_next_ofy, z, false)
				&& !collision3_line(x - next_next_ofx, y - next_next_ofy, next_next_x - next_next_ofx, next_next_y - next_next_ofy, z, false))
			{	
				// We've might as well made it to the currnet one
				m_aipath_current += 1;
				m_aipath_failtime = 0.0;
			}
			
			m_aipath_state_shortcutCheckTime = min(1.0, m_aipath_state_shortcutCheckTime - 1.0);
		}
	}
	else
	{	// If there was an error in the path, we kill the path.
		m_aipath_listing = null;
		m_aipath_newpath = true;
	}
}

// Update visualizer
m_aipath_visualize_nextPosition = [next_x, next_y];

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
	if (iexists(closestNodeStart))
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
var t_arrivalDistance = min(16, kMoveSpeed / 12);
if (ddist > t_arrivalDistance)
{	
	// Move to the target!
	
	// Calculate decelleration for arrival behavior
	var t_effectiveSpeed = (m_aiScript_requestSpeed != 0.0) ? m_aiScript_requestSpeed : 1.0;
	
	var t_goalDeccelerationTime = dspeed / kMoveAccelerationStop;
	var t_goalDecceleration = clamp(ddist / t_goalDeccelerationTime, 0.0, 1.0);
	if (!m_aipath_state_onLast)
	{
		t_goalDecceleration = 1.0;
	}
	else
	{
		if (t_goalDecceleration < 0.99)
		{
			t_goalDecceleration = 0.0;
		}
	}
	
	// Set the initial motion towards the target
	var t_controlVector = [clamp(dx / max(1, ddist), -1.0, +1.0), clamp(dy / max(1, ddist), -1.0, +1.0)];
	
	// TODO: add simple boid-style obstacle avoidance by "guessing" the normal (just add 90 degrees to the motion)
	
	// if something is in the way, then guess a normal with it based on surrounding collision boxes
	var t_forwardCheck = [x + t_controlVector[0] * 16, y + t_controlVector[1] * 16];
	if (collision3_meeting(t_forwardCheck[0], t_forwardCheck[1], z, true))
	{
		// Check left & right spots
		if (!collision3_meeting(t_forwardCheck[0] + t_controlVector[1] * 16, t_forwardCheck[1] - t_controlVector[0] * 16, z, true))
		{
			t_controlVector = [t_controlVector[0] + t_controlVector[1], t_controlVector[1] - t_controlVector[0]];
			//t_controlVector = [+t_controlVector[1], -t_controlVector[0]];
		}
		else if (!collision3_meeting(t_forwardCheck[0] - t_controlVector[1] * 16, t_forwardCheck[1] + t_controlVector[0] * 16, z, true))
		{
			t_controlVector = [t_controlVector[0] - t_controlVector[1], t_controlVector[1] + t_controlVector[0]];
			//t_controlVector = [-t_controlVector[1], +t_controlVector[0]];
		}
	}
	
	// if character is in the way, then avoid
	var t_forwardNpcCheckRadius = min(k_aipath_npcAvoidRadius * 0.5, ddist);
	if (t_forwardNpcCheckRadius > 5)
	{
		var t_forwardNpcCheck = [x + t_controlVector[0] * t_forwardNpcCheckRadius, y + t_controlVector[1] * t_forwardNpcCheckRadius];
		var t_forwardNpc = collision_circle(
			t_forwardNpcCheck[0], t_forwardNpcCheck[1],
			t_forwardNpcCheckRadius,
			ob_characterGround, false, true);
		if (iexists(t_forwardNpc))
		{
			if (abs(t_forwardNpc.xspeed) < 0.05 && abs(t_forwardNpc.yspeed) < 0.05)
			{
				// Check if it's on the left or right of the current path, and move around accordingly
				var path_difference = angle_difference(point_direction(0, 0, t_controlVector[0], t_controlVector[1]),
													   point_direction(x, y, t_forwardNpc.x, t_forwardNpc.y));
			
				if (path_difference > 0)
				{
					t_controlVector = [t_controlVector[0] + t_controlVector[1], t_controlVector[1] - t_controlVector[0]];
				}
				else
				{
					t_controlVector = [t_controlVector[0] - t_controlVector[1], t_controlVector[1] + t_controlVector[0]];
				}
			}
			else // TODO: change this for in-motion since the logic needs to be slightly different
			{
				// Check if it's on the left or right of the current path, and move around accordingly
				var path_difference = angle_difference(point_direction(0, 0, t_controlVector[0], t_controlVector[1]),
													   point_direction(x, y, t_forwardNpc.x, t_forwardNpc.y));
			
				if (path_difference > 0)
				{
					t_controlVector = [t_controlVector[0] + t_controlVector[1], t_controlVector[1] - t_controlVector[0]];
				}
				else
				{
					t_controlVector = [t_controlVector[0] - t_controlVector[1], t_controlVector[1] + t_controlVector[0]];
				}
			}
		}
	}

	// Normalize the control vector if larger than 1.0
	var t_controlLen = sqrt(sqr(t_controlVector[0]) + sqr(t_controlVector[1]));
	t_controlVector[0] /= max(1.0, t_controlLen);
	t_controlVector[1] /= max(1.0, t_controlLen);
	
	// Apply actual control
	_controlStructUpdate(xAxis, t_controlVector[0] * t_effectiveSpeed * t_goalDecceleration);
	_controlStructUpdate(yAxis, t_controlVector[1] * t_effectiveSpeed * t_goalDecceleration);
}
else
{	
	// Close enough, we can stop
	_controlStructUpdate(xAxis, 0.0);
	_controlStructUpdate(yAxis, 0.0);
}