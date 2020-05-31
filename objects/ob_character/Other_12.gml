/// @description On Stun (stun > max)

stats.m_stun = 0.0;

m_isStunned = true;
m_stunTimer = max(0, m_stunTimer) + stats.m_staggerTime;