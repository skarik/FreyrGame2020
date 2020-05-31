/// @function playerCheckpointSave(x, y, room)
/// @param x {Real}
/// @param y {Real}
/// @param room {Room}

var pl = getPlayer();
with (pl)
{
	m_checkpoint_valid = true;
	m_checkpoint_x = argument0;
	m_checkpoint_y = argument1;
	m_checkpoint_room = argument2;
}