/// @function checkpointInfoUnlock(checkpoint)
/// @param checkpoint {Instance}
function checkpointInfoUnlock(argument0) {

	var checkpoint = argument0;

	with (kQuestManager)
	{
		// checkpoint_list updated as game runs
		// [0] : room (id)
		// [1] : id (string)
		// [2] : desc (string)
	
		var last_sibling_checkpoint_index = -1;
	
		// Search if the checkpoint is in the existing list
		var checkpoint_count = array_length_1d(checkpoint_list);
		for (var i = 0; i < checkpoint_count; ++i)
		{
			var checkpoint_in_list = checkpoint_list[i];
		
			if (checkpoint_in_list[0] == room)
			{
				if (checkpoint_in_list[1] == checkpoint.m_checkpointName)
				{
					// Already in list & unlocked.
					return true;
				}
				// Save the checkpoint with matching room
				last_sibling_checkpoint_index = i;
			}
		}
	
		// If not in the list, we add it (next to the same place with the room)
		// First we have to copy things
		for (var i = checkpoint_count; i > last_sibling_checkpoint_index + 1; --i)
		{
			checkpoint_list[i] = checkpoint_list[i - 1];
		}
		// Then insert into list
		checkpoint_list[last_sibling_checkpoint_index + 1] = [room, checkpoint.m_checkpointName, checkpoint.m_checkpointDesc];
	
		return true;
	}

	return false;


}
