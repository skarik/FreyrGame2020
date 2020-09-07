function checkpointTeleportTo(argument0, argument1) {
	// @function checkpointTeleportTo(room, checkpoint_id)
	// @param room {Room}
	// @param checkpoint_id {String}

	var target_room = argument0;
	var target_checkpoint = argument1;

	var teleporter = inew(o_usableCheckpoint_Teleporter);
	teleporter.m_nextRoom = target_room;
	teleporter.m_nextCheckpoint = target_checkpoint;

	transition_to(target_room);


}
