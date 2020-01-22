/// @description update depth & visiblity

// Don't draw if off-screen. These have a lot of draw calls, can slow a massive room down.
if (point_on_camera(x, y)
	|| point_on_camera(m_wireTarget.x, m_wireTarget.y)
	|| point_on_camera((x + m_wireTarget.x) * 0.5, (y + m_wireTarget.y)  * 0.5))
{
	visible = true;
}
else
{
	visible = false;
}

if (visible)
{
	depthUpdate();
	depth -= m_depthOffset / 3.0;
}