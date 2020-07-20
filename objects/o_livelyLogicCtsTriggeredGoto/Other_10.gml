/// @description Create the Goto

var callee = id;
with (m_cutsceneTarget)
{
	cutsceneJumpToLabel(callee.m_cutsceneLabel);
}