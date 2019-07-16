
var o_seed = mt19937_get_state();
mt19937_seed(id);

// Start path with center point
m_aiGobbo_patrol[0] = [m_aiGobbo_centerX, m_aiGobbo_centerY];

// Essentially path from the start
var path_walker_pos = [m_aiGobbo_centerX, m_aiGobbo_centerY];
var path_dir_prev = -1;

for (var pathi = 0; pathi < 2; pathi++)
{
	// Choose a direction
	var dir = path_dir_prev;
	if (dir == -1)
		dir = (mt19937_rand() % 4) * 90;
	else {
		if (mt19937_rand() % 2)
			dir += ((mt19937_rand() % 3) - 1) * 90;
		else
			dir += (mt19937_rand() % 2) ? -90 : 90;
	}
	path_dir_prev = dir;
	// Choose a distance
	var dist = mt19937_random_range(64.0, 128.0);
	
	// Walk along that line (distance & direction)
	var step_amount = 4.0;
	var step_vector = [lengthdir_x(step_amount, dir), lengthdir_y(step_amount, dir)];
	var step_hitWall = false;
	
	for (var walk_amount = 0; walk_amount < dist; walk_amount += step_amount)
	{
		if (!collision3_meeting(path_walker_pos[0] + step_vector[0], path_walker_pos[1] + step_vector[1], z, false))
		{
			path_walker_pos[0] += step_vector[0];
			path_walker_pos[1] += step_vector[1];
		}
		else
		{
			step_hitWall = true;
			break;
		}
	}

	// Save the position in the patrol path
	m_aiGobbo_patrol[array_length_1d(m_aiGobbo_patrol)] = [path_walker_pos[0], path_walker_pos[1]];
	
	// Consider breaking from path immediately
	if (step_hitWall) {
		if (mt19937_random_range(0.0, 1.0) < 0.20)
			break; // Try not to stop at walls
	}
	else {
		if (mt19937_random_range(0.0, 1.0) < 0.50)
			break;
	}
}

// Restore original seed
mt19937_set_state(o_seed);