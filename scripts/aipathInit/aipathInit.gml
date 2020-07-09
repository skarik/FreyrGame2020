#region Configurable Constants
k_aipath_npcAvoidRadius = 24;
#endregion

#region Visualize State
m_aipath_visualize_nextPosition = [0, 0];
#endregion

#region Pathing State
m_aipath_listing = null;
m_aipath_current = 0;
m_aipath_failtime = 0.0;
m_aipath_repathtime = 0.0;

m_aipath_state_onLast = false;
m_aipath_state_shortcutCheckTime = 0.0;

m_aipath_newpath = false; // Request new path
m_aipath_newpath_cooldown = 0.0;
m_aipath_targetX = 0;
m_aipath_targetY = 0;
m_aipath_targetRoom = room;
#endregion
