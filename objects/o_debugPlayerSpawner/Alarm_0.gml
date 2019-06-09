/// @description Create player!

var pl = instance_create_depth(x, y, depth, o_PlayerTest);

var companion = null;
if (object_exists(m_companion) && !exists(m_companion))
{
	companion = instance_create_depth(x, y, depth + 1, m_companion);
}
if (exists(companion))
{
	aiscriptRequestStart(companion, kAiStyle_Follow);
}