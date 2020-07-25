var t_spawnGuard = collision_circle(x, y, 8, o_aiGaurdStand, false, true);
var t_spawnPush = collision_circle(x, y, 8, o_aiPushOnSpawn, false, true);

var init_patrol_path = !iexists(t_spawnGuard) && iexists(m_patrolPathStart);
var init_gaurd_point = iexists(t_spawnGuard);
var init_spawnpush = iexists(t_spawnPush);

if (init_spawnpush)
{
	// TODO
}
else if (init_patrol_path)
{
	m_aiNPC_patrolPathnode = m_patrolPathStart;
	m_aiNPC_state = kAiNPCGuardState_DefinedPatrol;
}
else if (init_gaurd_point)
{
	m_aiNPC_patrolGuardpoint = t_spawnGuard;
	m_aiNPC_state = kAiNPCGuardState_DefinedGuard;
	
	m_aiNPC_centerX = t_spawnGuard.x;
	m_aiNPC_centerY = t_spawnGuard.y;
}