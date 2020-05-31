/// @description Create player!

var pl = instance_create_depth(x, y, depth, o_PlayerTest);

var companion = null;
if (object_exists(m_companion) && !iexists(m_companion))
{
	companion = instance_create_depth(x, y, depth + 1, m_companion);
}
if (iexists(companion))
{
	aiscriptRequestStart(companion, kAiStyle_Follow);
}