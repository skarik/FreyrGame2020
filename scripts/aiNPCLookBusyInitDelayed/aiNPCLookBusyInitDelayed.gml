
var o_seed = mt19937_get_state();
mt19937_seed(id);

// Start path with center point
m_aiNPC_patrol[0] = [m_aiNPC_centerX, m_aiNPC_centerY];

// Essentially path from the start
var path_walker_pos = [m_aiNPC_centerX, m_aiNPC_centerY];
var path_dir_prev = 0;

for (var pathi = 0; pathi < 2; pathi++)
{
	// Choose a direction
	var dir = path_dir_prev;

	if (path_dir_prev == 0)
		dir = (mt19937_rand() % 2) ? 1 : -1;
	else
		dir *= -1;

	path_dir_prev = dir;
	
	// Choose a distance
	var dist = 64.0;
	
	// Walk along that line (distance & direction)
	var step_amount = 4.0;
	var step_vector = [step_amount * dir, 0]; //Just go left and right for now
	var step_hitWall = false;
	
	for (var walk_amount = 0; walk_amount < dist; walk_amount += step_amount)
	{
		//Keep walking unless the NPC bumps into something
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
	m_aiNPC_patrol[array_length_1d(m_aiNPC_patrol)] = [path_walker_pos[0], path_walker_pos[1]];
	
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