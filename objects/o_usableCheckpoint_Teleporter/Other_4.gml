/// @description Teleport player

// Find the checkpoint
var callee = id;
var checkpoint = null;
with (o_usableCheckpointMinor)
{
	if (m_checkpointName == callee.m_nextCheckpoint)
	{
		checkpoint = id;
	}
}

// Move player
var pl = getPlayer();
with (pl)
{
	// move to the checkpoint
	x = checkpoint.x;
	y = checkpoint.y + 32;
	
	// update the Z now
	z = collision3_get_highest_meeting(x, y, z);
	z_height = 0;
}


// Done with self
idelete(this);