/// @description delet
if (!exists(m_target)) {
	delete(this);
	exit;
}
	
depth = m_target.depth + 1;
x = m_target.x;
y = m_target.y;